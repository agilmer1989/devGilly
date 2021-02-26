show " " sv .z.X
\l util.q
\l schema.q
\l results.q
\l config.q

/ would like a nicer way of configuring tests
\l testWrite.q
\l testRead.q

.cmd.db:`:./db/
.cmd.cwd:raze system"pwd"

/ build trade table defined in schema.q
/ mock some data based on config dict
/ column count and attributes can be modified in schema.q
initData:{[config]
	system"l schema.q"; / normally have a nicer way of handling relative filepaths and file loading
	rowCount:config[`rowCount];
	valueMap:"tsfibc"!(.z.t;neg[config[`symCount]]?`5;100.0;100i;10b;.Q.a); / limited by number of distinct symbols using this logic 
	rowCount:config[`rowCount];
	tableName:config[`tableName];
	sampleData:flip ?[rowCount] each valueMap exec c!t from meta[trade];
	tableName upsert `sym`time xasc sampleData;
	}

/ run configured tests. this should be made programatic so more test can be added easily with having to add them to this function
runTests:{[config]
	testWrite[config];
	testRead[config];
	}

/ persist results table , simple save as csv in this case to curreny working directory
/ bit of dupe code here, can be refactored
saveResults.csv:{[]
	runId:last exec runId from results; / stamp on the correlator to the filename
	fileName:`$"results_",string[runId],".csv";
	path:.Q.dd[hsym `$.cmd.cwd;fileName];  / add path to config 
	stdout"saving results to ",string path;
	path 0: csv 0: results
	}

saveResults.kdb:{[]
	runId:last exec runId from results;
	fileName:`$"results_",string[runId];
	path:.Q.dd[hsym `$.cmd.cwd;fileName];
	stdout"saving results to ",string path;
	path set results
	}

/ clean up the data, run a gc and wipe out the hdb.
/ if we want to be more accurate the kernal caches should be flushed too
clean:{
	delete trade from `.;
	.Q.gc[];
	stdout "deleting data from disk"
	system"cd ",.cmd.cwd;
	system"rm -rf ./db";   / would normally us mv instead of rm as a rule of thumb
	}


main:{[config]
        stdout "running tests with config:"
        config[`runTime]:.z.P;   / stamp on a runtime to correlate results
        show config;
        initData[config];
        runTests[config];
        clean[];
        }


if[`help in key opts:.Q.opt .z.x;
	stdout"###";
	stdout"tester.q used to generate hdb disk performance metrics";
	stdout"usage: q tester.q [-outputFormat [kdb|csv]] [-debug]";
	stdout"###";
	exit 0
	];

/ -debug mode will load the script but not run anything
if[not `debug in key opts;
	main each configTable;
	outputFormat:$[`outputFormat in key opts;
		first `$opts[`outputFormat];
		`csv
		];
	saveResults[outputFormat][];
	stdout "result saved in 'results' table";
	]	

