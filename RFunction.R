library('move2')
library('dplyr')
library("lubridate")

rFunction <- function(time_numb=NULL, time_unit=NULL, data){
  tl <- mt_time_lags(data, units = "min")
  logger.info(paste0("Timelag summary of your data. Minimum ",round(min(tl,na.rm=T),3)," minutes","; meadian: ",round(median(tl,na.rm=T),3)," minutes", " ; maximum: ",round(max(tl,na.rm=T),3)," minutes"))
  logger.info(paste("Your data will be thinned as requested to one location per",time_numb,time_unit))
  data <- data[order(mt_track_id(data),mt_time(data)),] # just to be safe
  thinned_data <- mt_filter_per_interval(data,criterion="first",unit=paste(time_numb,time_unit))
  thinned_data <- thinned_data %>% group_by(mt_track_id()) %>% slice(-1) ## the thinning happens within the time window, so the 1st location is mostly off. After the 1st location the intervals are regular if the data allow for it
  thinned_data <- ungroup(thinned_data)
  if(nrow(thinned_data)>0){
  tlt <- mt_time_lags(thinned_data, units = "min")
  logger.info(paste0("Timelag summary of your thinned data. Minimum ",round(min(tlt,na.rm=T),3)," minutes","; meadian: ",round(median(tlt,na.rm=T),3)," minutes", " ; maximum: ",round(max(tlt,na.rm=T),3)," minutes. ",length(tlt[which(round(tlt)<round(median(tlt,na.rm=T)))]), " timelags (from ",length(tlt)," in total) are below the median."))
  } else {
    logger.info(paste0("With the current settings not data are be retained. The resulting dataset is empty."))
  }
  return(thinned_data)
}