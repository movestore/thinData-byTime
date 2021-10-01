library('move')
library('lubridate')
library('foreach')

rFunction <- function(time=NULL, unit=NULL, meth="simple", data) 
{
  Sys.setenv(tz="UTC") 
  if (is.null(unit))
  {
    logger.info(paste0("You have not chosen a unit for your resolution. Please add one of the following: 'sec', 'min','hour','day','week'. Here we impose 'hour' if a time resolution is provided."))
    unit <- 'hour'
  }
  
  if (is.null(time))
  {
    logger.info(paste0("You have not chosen a resolution. Please add one. Return full data set."))
    result <- data
  } else
  {
    logger.info(paste("You have selected to thin the data to a resolution of",time,unit,"."))

    if (meth=="simple")
    {
      result <- data[!duplicated(paste0(round_date(timestamps(data), paste0(time," ",unit)), trackId(data))),]
    } else #if (meth %in% c("closest","first","all") #need to ask move people
    #{
    #  logger.info(paste("You have selected advanced thinning. Long duration for large data sets. Here impose tolerance of",time/2,unit,".")
    #  itv <- as.difftime(tim=time,units=paste0(unit,"s"))
    #  tol <- itv/2 #careful, this parameter is very important not to select too small
    #  data.split <- move::split(data)
    #  result <- foreach(datai = data.split) %do% {
    #    print(namesIndiv(datai))
    #    burst <- thinTrackTime(x=datai,interval=itv,tolerance = tol, criteria=meth[1])  #careful here output is MoveBurst! And output aims to provide segments with min and max (!) time requirements! Think here only min requirement necessary
    #    sel <- moveStack(move::split(burst)[names(move::split(burst))=="selected"])
    #    move(x=coordinates(sel)[,1],y=coordinates(burst)[sel,2],time=timestamps(burst)[sel],data=burst@data[sel,],proj="+proj=longlat +ellps=WGS84",sensor=sensor(burst)[sel],animal=namesIndiv(datai))
    #  }
    #  names(result) <- names(data.split)
    #} else 
    {
      logger.info("No proper method provided. Return full data set.")
      result <- data
    }
  }
  result
}