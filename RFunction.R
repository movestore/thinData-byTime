library('move')
library('lubridate')
library("amt")

rFunction <- function(time=NULL, unit=NULL, toleranceTime=0, toleranceUnit="seconds", data){
  Sys.setenv(tz="UTC") 
  if(is.null(unit)){
    logger.info(paste0("You have not chosen a unit for your resolution. Please add one of the following: 'sec', 'min','hour','day','week'. Here we impose 'hour' if no time unit is provided."))
    unit <- 'hour'
  }
  if(is.null(time)){
    logger.info(paste0("You have not chosen a resolution. Please add one. Return full data set."))
    thinned_data <- data
  }
  if(!is.null(time)&!is.null(unit)&!is.null(toleranceTime)&!is.null(toleranceUnit)){
    tol <- period(num = toleranceTime, units = toleranceUnit)
    timerate <- period(num = time, units = unit)
    if(tol>=timerate){
      logger.info(paste0("You have chosen a tolerance that is equal or higer than the chosen time resolution. The tolerance must always be smaller. Return full data set."))
      thinned_data <- data
    }else{
      logger.info(paste("You have selected to thin the data to a resolution of",time,unit,"with a tolerance of",toleranceTime, toleranceUnit,"."))
      
      # Create a track_xyt object (amt package)
      data_tracks <- track(x=coordinates(data)[,1],
                           y=coordinates(data)[,2],
                           t=timestamps(data),
                           id=trackId(data),
                           crs = CRS(projection(data)))
      # subsample to 1 location per chosen resolution and tolerance
      data_tracks_L <- split(data_tracks, data_tracks$id)
      data_tracks_thinned_L <- lapply(data_tracks_L, function(x){track_resample(x, rate = timerate, tolerance = tol, start = 1)}) ## "start" DETERMINES THE POSTION FROM WHICH TO START THE THINING, WE COULD THINK ABOUT IF IT MAKES SENSE TO ADD IT
     
      # # Create move object 
      # thinned_data <- moveStack(lapply(data_tracks_thinned_L, move), forceTz="UTC")
      
      # probably the more complicated way, but it makes sure the movestack stays as is without losing any of the attributes when transforming back and forth
      thinned_data_L <- lapply(names(data_tracks_thinned_L), function(indv){
        mv <- data[[indv]]
        mvt <- mv[timestamps(mv)%in%data_tracks_thinned_L[[indv]]$t_,]
        return(mvt)
      })
      thinned_data <- moveStack(thinned_data_L, forceTz="UTC")
    }
  }
  return(thinned_data)
}