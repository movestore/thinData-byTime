# thinData-byTime

## Description
Movement data are thinned (subsampled) to a user-provided maximum time resolution. 

## Documentation
This App subsamples (thins) the provided Movement data set to a maximum time resolution. This means that intermediate points are deleted so that the time difference between two positions (of the same individual) is at the most the provided resolution, e.g. "one position per hour" leads to time difference of at least one hour.

The presently implemented algorithm simply takes the first location of each time resolution interval. This can result in a non-optimal thinned data set (i.e. with less locations than otherwise possible), but is the fastest and easiest option.

### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
none

### Parameters 
`time`: Numeric variable to define the time resolution. Has to be seen in combination with `unit`. Example: 1.5.
`unit`: Dropdown to select the time unit that the resolution is given in. Defines the `time`number variable. Example: "hour". 
`meth`: 

### Null or error handling:
**Parameter `time`:** If no time resolution parameter is provided the App does not thin the data and returns the input data set. If a non-numeric value is entered by the user this case is handled as NULL, i.e. the App returns the input data set.

**Parameter `unit`:** If no unit is selected from the dropdown the default "hour" is used. 

**Data:** The output data set will retain at least the first position for each individual and should therefore not become empty.