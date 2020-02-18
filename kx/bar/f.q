/ setup
t:([]time:12:00:00.000+1000*til 27;sym:27#3#`$'.Q.A;col1:sum each (-1 0.5 -1.5 -0.5 2 -2 0 -0.25 1)cross 10 20 30;col2:27#100 200);

ensureList:{count[x]#x}

f:{[columns;groupBy;tbl]
	/ 1 validate inputs
	if[count missing:(columns,groupBy) except cols tbl;
		show "missing columns ",string "," sv string missing;
		'missing_cols
		];
	/ ensure each input is a list
	columns:ensureList columns;
	groupBy:ensureList groupBy;
	?[tbl;();groupBy!groupBy;columns!columns]
	}

show f[`time`col2;`sym`col1;t] ~ select time,col2 by sym,col1 from t
