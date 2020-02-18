## Question 1: &':/
Explain following q output
```
	q) 2 &':/3 1 4 5 2 0N 7 6 8
 	3 1 1 1 2 0N 0N 0N 6
```
### Answer 1
This is giving the 3-item moving minimums of the list of ints. 
Because we are using & as min instead of 'min'Nulls are treated as a minimum value
```
	q)0N&1
 	0N
 	q)min 0N 1
 	1
```
k operators used are; 

	& min
	': prior 
	/ over

Iterating across the list on the right and apply the min of x=2 and y=n

	1) first item in list = 3
	2) 0N&3&1 = 1
	3) 3&1&4  = 1
	4) 1&4&5  = 1
	5) 4&5&2  = 2
	6) 5&2&0N = 0N
	7) 2&0N&7 = 0N 
	8) 0N&7&6 = 0N 
	9) 7&6&8  = 6

## Question 2: iscurrentmax.q

For a given table; Add a (boolean) column which is TRUE if "val" us the maximum value  within the corresponding or older date

```
	date       val
	--------------
	2014.09.01 10
	2014.09.02 15
	2014.09.03 40
	2014.09.04 5
	2014.09.05 1
	2014.09.06 90
```

### Answer 2
```
	update iscurrentmax:val=maxs val from t
	date       val iscurrentmax
	---------------------------
	2014.09.01 10  1
	2014.09.02 15  1
	2014.09.03 40  1
	2014.09.04 5   0
	2014.09.05 1   0
	2014.09.06 90  1
 
```
## Question 3: exists.q
Write a function ```exists``` which takes a variable symbol v and returns 1b if v is defimed and 1b if it is not


### Answer 3
```
	/ function takes a symbol and returns true or false depending of wether that variable exists or not
	/@test 
	/	q)a: 10
	/ 	q)exists `a
	/	1b
	/	q) exists `b
	/	0b
	/	q) exists `.q
	/	1b
	/@params variable (symbol) variable name to test existence of
	/@return (boolean) true variable exists, false variable not defined
	exists:{[variable]
		if[isVariable:variable in system"v";:1b];
		if[isFunction:variable in system"f";:1b];
		if[isContext:variable in key `;:1b];
		if[isView:variable in views[];:1b];
		isDefined:not `not_defined~@[value;variable;`not_defined];
		isDefined
		}

``` 

## Question 4: dependson.q

Depends on me: In q we define a view or dependency with '::', e.g.
```
	a:10
	b::a+1
	c::a+2
	d:c+20
	e::b+d
	f:e+4
	g::f+5
```
In this example, if a is reassigned, then b, c, e, f and g are invalidated. Referencing an invalid variable causes its definitions to recompute and return a new value.

In general if any variable is invaldiated then all of its descendents are invalidated.

The primative .z.b takes one or more symbols s and for each symbol k in s returns a vector of symbols of variables whcih directly depend on k;
```
	q).z.b `a`d
	`b`c
	,`e 
```
Write a function `dependson` which takes a single symbol `v` and returns a list of ALL the variables which are invalidated by assignent ot v, e.g.: 
```
	q)dependson `a
	`a`b`c`e`f`g
```

### Answer 4

```
	/function takes single symbol v and returns a list of all variables which are dependent on v
	/@param v (symbol) variable name
	/@return (list) list of dependants
	dependson:{[v]
		raze count(raze .z.b@)\v
		}	
```	
Test:

```
	q)dependson[`a]~`a`b`c`e`f`g
	1b
```

## Question 5: reorder.q

Given a list of expressions 
```
	d:c+b
	c:-b
	e:d*a
	b:10
	a:20
```
We want to reorder them to that each variable is computed before it is used:
```
	b:10
	c:-b
	a:20
	d:c+b
	e:d*a
```
Represent the expression list as an appropriate dictionary s. Example:
```
	s:`d`c`e`b`a!(`c`b;`b;`d`a;0#`;0#`)
```
There is a function that computes the reordering, e.g. 
```
	reorder s
	`b`c`d`a`e
```
### Answer 5

```
	ensureList:{count[x]#x}

	/ function shuffle takes a dictionary of dependencies and reorders them so that correct dependencies are referenced first
	/@param dict (dictionary) dictionary to reorder
	/@param from (symbol) key from the dictionary to reorder below its corresponding depends
	/return dictionary
	shuffle:{[dict;from]
		below:dict from;
        	order:key dict;
        	fromIndex:order?from;
        	maxIndex:max where max ensureList[below]=\:order;
        	if[fromIndex<maxIndex;
                	newOrder:maxIndex#order except from;
                	dict:(newOrder,from) xcols dict
                	];
        	dict
        	}

	/@param expressions (dictionary) a dictionary representing expression definitions
	/@return symbol list
	reorder:{[expressions]
		if[not 99h=type expressions;
			show "invalid input";
			'bad_input
			];
		reordered:expressions shuffle/key expressions;
		key reordered
		}
	
```
Test:
```
	q)reorder s~`b`c`d`a`e
	1b
```
## Question 6: typeMap.q

Type Map: Write a function to create a dictionary that maps the type character to the null and the uppercase type character to the correctly typed empty list:
```
	i| 0Ni
	I| `int$()
```

### Answer 6
```
	typeMap:{[]
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
  
```

Test:

```
	q)typeMap[]
	b| 1b
	B| `boolean$()
	g| 00000000-0000-0000-0000-000000000000
	G| `guid$()
	x| 0x00
	X| `byte$()
	h| 0Nh
	H| `short$()
	i| 0Ni
	I| `int$()
	j| 0N
	J| `long$()
	..

```

## Question 7: loop.q
Graphs: Represent a graph using an appropriate dictionary to show the edges. Example:
```
	d.a:`b`e
	d.b:`c`d
	d.c:`
	d.d:enlist `e
	d.e:`f`g
	d.g:enlist `d
```
Rrepresents:
```
	a -> b  -> c
	|    |
	|    +->d<--+
	v	|   |
	e <-----+   |
       / \          |
      v	  v         |
      f   g --------+
```
Write function `loop` which detects the existence of cycles (loops) in a graph like the one above. 

Example return options:
```
	q)loop d
	,`e
	q)loop d
	`d`e`g
```
### Answer 7

```
	dependencies:{[dict;ky]
        	where 1<count each group raze count[dict] (raze dict@)\ky
        	}

	loop:{[dict]
        	if[(::)~first dict;
                	dict:1_dict
                	];
		/ make sure all values in dict have a corresponding key
		dict:((distinct raze value dict) except `) # dict;
        	repeatingKeys:dependencies[dict] each key dict;
		endpoints:key[dict] where 0=count each repeatingKeys;
        	distinct[raze repeatingKeys] except endpoints,`
        	}
		
```
Now try adding some nodes to test this works in different scenarios

```
	/case 1: d as defined above
	 | ::
	a| `b`e
	b| `c`d
	c| `
	d| ,`e
	e| `f`g
	g| ,`d

	loop d
	`d`e`g

	/case 2: link node f to c
	 | ::
	a| `b`e
	b| `c`d
	c| `
	d| ,`e
	e| `f`g
	g| ,`d
	f| `c`g

	loop d
	`d`e`f`g

	/case 3: Add node  h between f and c. Expect result to be same as in case 1
	 | ::
	a| `b`e
	b| `c`d
	c| `
	d| ,`e
	e| `f`g
	g| ,`d
	f| `h
	h| `c

	loop d
	`d`e`g

```
## Question 8: f.q

Functional select: Given the below table write a function f to select any column or combination of columns by any other column or combination

```
	t:([]time:12:00:0.000+1000*til 27;sym:27#3#`$'.Q.A;col1:sum each (-1 0.5 -1.5 -0.5 2 -2 0 -0.25 1)cross 10 20 30;col2:27#100 200);

	f[`time`col2;`sym`col1;t] ~ select time,col2 by sym,col1 from t
```

### Answer 8

```

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

```

Test:

```
	q)f[`time`col2;`sym`col1;t] ~ select time,col2 by sym,col1 from t
	1b
```

