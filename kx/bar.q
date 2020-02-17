/ 1) Explain following q output
/ q) 2 &':/3 1 4 5 2 0N 7 6 8
/ 3 1 1 1 2 0N 0N 0N 6
/ This is giving the 3-item moving minimums of the list of ints. 
/ Because we are using & as min instead of 'min'Nulls are treated as a minimum value
/ q)0N&1
/ 0N
/ q)min 0N 1
/ 1
/ /
/ k operators used are; 

/ & min
/ ': prior 
/ / over

/ Iterating across the list on the right and apply the min of x=2 and y=n

/ 1) first item in list = 3
/ 2) 0N&3&1 = 1
/ 3) 3&1&4  = 1
/ 4) 1&4&5  = 1
/ 5) 4&5&2  = 2
/ 6) 5&2&0N = 0N
/ 7) 2&0N&7 = 0N 
/ 8) 0N&7&6 = 0N 
/ 9) 7&6&8  = 6

//2)
update iscurrentmax:val=maxs val from t 

//3) 
exists:{[variable]
	if[isVariable:variable in system"v";:1b];
	if[isFunction:variable in system"f";:1b];
	if[isContext:variable in key `;:1b];
	if[isView:variable in views[];:1b];
	isDefined:not `not_defined~@[value;variable;`not_defined];
	isDefined
	}
 
 // 6
 
 typeMap:{
	map:{[char]
		/ upper case return type casted list , lower case return null 
		isNumeric:not char in "sScCgG ";
		mapKey:(lower;upper)@\:char;
		dict:$[isNumeric;
			mapKey!(char$0N;char$());
			char in "gSs ";
			mapKey!(upper[char]$"";char$());
			mapKey!("";())
			];
		dict
		}each .Q.t except " ";
	raze map
	}
  
  // 8)
  
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
		
