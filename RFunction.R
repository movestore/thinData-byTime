library('move')
library('lubridate')


rFunction <- function(time=NULL, unit=NULL, data)
{
  if (is.null(unit))
  {
    logger.info(paste0("You have not chosen a unit for your resolution. Please add one of the following: 'second', 'minute','hour','day','week','month','year'. Here we impose 'hour' if a resolution is provided."))
    unit <- 'hour'
  }
  
  if (is.null(time))
  {
    logger.info(paste0("You have not chosen a resolution. Please add one. Return full data set."))
    result <- data
  } else
  {
    logger.info(paste0("You have selected to thin the data to a resolution of ",time,unit,"."))
    
    if (class(data)=="MoveStack")
    {
      result <- data[!duplicated(paste0(round_date(timestamps(data), paste0(time," ",unit)), trackId(data))),]
    } else
    {
      result <- data[!duplicated(round_date(timestamps(data), paste0(time," ",unit))),]
    }
  }
  result
}