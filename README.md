# Thin Data by Time
MoveApps

Github repository: *github.com/movestore/thinData-byTime*

## Description
Movement data are thinned (subsampled) to a user-provided time interval. 

## Documentation
This App subsamples (thins) the provided Movement data set to the set time interval.
The App selects the first event per defined interval (time window). Depending on the data, the time lag between consecutive locations of the thinned data might not correspond exactly to the time interval. 
For example, if the defined time interval is "1 hour", the App will select the location that within the time window e.g. 10:00:00-10:59:59 is closest to 10 o'clock. If the data are irregular, the thinned data could contain the timestamps 9:05, 10:05, 11:25, 12:05, with the resulting time lags of 1h, 1h20mins, 40mins. 
When thinning the track to a lower frequency than its original fix rate, the time lags will mostly correspond to the defined time interval.

After running the App, in the logs a summary (min, median, max in minutes) of the time lags of all tracks will be displayed. The median time lag will mostly correspond to the programmed fix rate of the tags. Which time interval makes sense to choose, will probably depend on the sampling rate of the data (e.g. use the app "Time Lag Between Locations" to find out sampling rate per track of the data before running this App) and the purpose of thinning the data (e.g. subsequent applied methods).


### Input data
move2_locs

### Output data
move2_locs

### Artefacts
none

### Settings 
**Time resolution (`time_numb`):** Numeric variable to define the time interval. Has to be seen in combination with `time_unit`. Default is 1.

**Unit (`time_unit`):** Dropdown to select the time unit that the interval is given in. Defines the `time_numb` numeric variable. Default is hour. 


### Null or error handling:
**Data:** If the time interval is set to large and no locations are retained, a empty data set will be passed on to the next App, and this App will then give an error.
