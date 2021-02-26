/ Use dpft to save trade table using config as per input dict
/@params config (dict) input params
/ @key compressionParams (list) compression params eg 17 2 6
/ @key tableAttributes (symbol) column.attribute ex `ex.g -> apply g hash to ex column
/ @key rowCount (long) length of table
/ @key columnCount (long) number of columns
/ @key tableName (symbol) tablename, trade
/ @key symCount (long) number of distinct symbols in database which are sorted and `p attr applied
testWrite:{[config]
        uncompressedSize:(-22!trade)%1000; / uncompressed size in Kb
        isCompressed:config[`compressionParams]~0 0 0;
        .z.zd:config[`compressionParams];
        st:.z.P;
        .Q.dpft[.cmd.db;.z.D;`sym;`trade];
        applyAttrOnDisk[.Q.par[.cmd.db;.z.d;`trade]] peach config[`tableAttributes]; / adding peach in here as attibutes can be parellelized
        et:.z.P;
        execTime:("j"$et-st)%1000; / time in us
        onDiskSize:"J"$first "\t" vs raze system"du -s ",1_string .cmd.db;
        res:update .Q.s1 each compressionParams, .Q.s1 each tableAttributes from enlist config;
        res:update opType:"write",isCompressed:isCompressed,executionTimeUs:execTime,memorySizeKb:uncompressedSize, diskUsageKb:onDiskSize from res;
        res:update throughputKbps:memorySizeKb%(executionTimeUs%10 xexp 6) from res;
        `results upsert res
        }

/@params loc (symbol) filepath to table
/@params attribute (symbol) column.attribute ex `ex.g -> apply g hash to ex column
applyAttrOnDisk:{[loc;attribute]
        column:first ` vs attribute;
        attribute:last ` vs attribute;
        @[loc;column;#[attribute]]
        }

