/ simple read time for full partition into memory
/ a lot of this is repeated code from writeTest.q , should be refactored
testRead:{[config]
	opType:"read";
	onDiskSize:"J"$first "\t" vs raze system"du -s ",1_string .cmd.db;
	system"l ",1_string .cmd.db;
	st:.z.P;
	uncompressedSize:(-22!select from trade where date=max date,i>-1)%1000;
	et:.z.P;
	isCompressed:config[`compressionParams]~0 0 0;
	execTime:("j"$et-st)%1000; / time in us
	res:update .Q.s1 each compressionParams, .Q.s1 each tableAttributes from enlist config;
	res:update opType:"read",isCompressed:isCompressed,executionTimeUs:execTime,memorySizeKb:uncompressedSize, diskUsageKb:onDiskSize from res;
	res:update throughputKbps:memorySizeKb%(executionTimeUs%10 xexp 6) from res;
	`results upsert res
	}


