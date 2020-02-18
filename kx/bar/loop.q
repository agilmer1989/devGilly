d.a:`b`e
d.b:`c`d
d.c:`
d.d:enlist `e
d.e:`f`g
d.g:enlist `d

/iterate through each node in the graph and return all connected steps to each node
dependencies:{[dict;ky] 
	where 1<count each group raze count[dict] (raze dict@)\ky
	}

loop:{[dict]
	if[(::)~first dict;
		dict:1_dict
		];
	dict:((distinct raze value dict) except `)# dict;
	repeatingKeys:dependencies[dict] each key dict;
	endpoints:key[dict] where 0=count each repeatingKeys; 
	distinct [raze repeatingKeys] except endpoints,`
	}

/----
show "test: loop d"
show d
/ expected output: `d`e`g
show loop d

d1:d
/link f to g . f g d e becomes a loop too
d1.f:`c`g

/----
show "test: loop d with f linked to c"
show d1
/ expected output :  `d`e`g`f
show loop d1

/----
show "test: loop d with extra node h between f and c"
d2:d
d2.f:`h
d2.h:`c
show d2
/ expected output:`d`e`g
show loop d2


