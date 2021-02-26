# Brief 
Candidate is to design and develop KDB application used to examine hardware storage performance for various historical database setups. Database organization and testing scenarios development is part of the assignment. The aim of storage performance test is to answer two questions: a) what is most efficient HDB setup for certain hardware, b) provide quantitative measure of estimated HDB performance.

# Usage
```
q tester.q [-outputFormat [kdb|csv]] [-debug] 
```

# Test Config
Configuration for each test will include following variables:
	* No. of columns / for pure io just write benchmarks writing one column of data
	* Row count
	* g# attributes
	* No. distinct `p#syms

Additionally I have added compression and encryption configs. 
nb. encryption breaks the on disk attribute application

# Metrics 

## writeTest.q
Saves the configured data on disk. Measures the memory footprint, the time to write and apply attributes on disk, and the disk usage post writedown.

Using .Q.dpft as the same function. This sorts and applies p# to the data before saving so this should also be taken into account.

## readTest.q
Uses same inputs and measures throughput metrics for read functions. 

# Results

Results are all collated in memory in a table called results;

```
runId            | correlator for test 
runTime          | time test starts
opType           | read test or write test
tableName        | `trade
rowCount         | number of rows in table
symCount         | number of distinct symbols in database
isCompressed     | is data compressed on disk
isEncrypted      | is data encrypted on disk
compressionParams| .z.zd 
columnCount      | number of columns in table
tableAttributes  | columns with additional attributes applied as per schema.q
executionTimeUs  | time to complete read/write operations
memorySizeKb     | output of -22! on data
diskUsageKb      | size of data on disk
throughputKbps   | memorySizeKb%executionTimeUs
```

Data is also saved automatically in csv format in the current working directory, or as a kdb binary if specified on command line.

# Additional Notes

I didn't add a test for append operations as I went over the 3 hours as per the description. I would have done this to and checked sort times etc.

As is the script breaks if encryption is used with attributes.
