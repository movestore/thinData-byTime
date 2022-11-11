# Thin Data by Time
MoveApps

Github repository: *github.com/movestore/thinData-byTime*

## Description
Movement data are thinned (subsampled) to a user-provided minimum time resolution. 

## Documentation
This App subsamples (thins) the provided Movement data set to a maximum time resolution with some tolerance (optional). This means that intermediate points are deleted so that the time difference between two positions (of the same individual) is at least the provided resolution, e.g. "one position per hour" leads to time difference of at least one hour. 
Optionally a time tolerance value can be provided, accounting this way for the small deviations that the original fix rates often have, as they are mostly not exact (e.g. tag has a fix rate of "1 position every 5 mins", but allows 2mins to search for GPS signal, so the actual sampling rate of the retrieved data will be between 3-7mins (excluding missed fixes)). When choosing to thin the data to e.g. "1 position per hour with a tolerance of 5 minutes", these deviations in the data get taken into account and more data are retained in the thinned dataset. Which tolerance value makes sense to choose, will probably depend on the sampling rate of the data (e.g. use the app "Time Lag Between Locations" to find out sampling rate of the data) and the purpose of thinning the data (e.g. subsequent applied methods). The default tolerance is "0 seconds", so no tolerance is applied.

### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
none

### Parameters 
`time`: Numeric variable to define the time resolution. Has to be seen in combination with `unit`. Example: 1.5.

`unit`: Dropdown to select the time unit that the resolution is given in. Defines the `time` numeric variable. Example: "hour". 

`toleranceTime`: Numeric variable to define the tolerance time resolution. Has to be seen in combination with `toleranceUnit`. Default is 0. Example: 10. 

`toleranceUnit`: Dropdown to select the time unit that the tolerance is given in. Defines the `toleranceTime` numeric variable. Default is "Seconds". Example: "minutes". 


### Null or error handling:
**Parameter `time`:** If no time resolution parameter is provided the App does not thin the data and returns the input data set. If a non-numeric value is entered by the user this case is handled as NULL, i.e. the App returns the input data set.

**Parameter `unit`:** If no unit is selected from the dropdown menu the default "hour" is used and a related warning is given.

**Data:** The output data set will retain at least the first position for each individual and should therefore not become empty.