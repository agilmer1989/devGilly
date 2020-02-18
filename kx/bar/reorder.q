s:`d`c`e`b`a!(`c`b;`b;`d`a;0#`;0#`)

ensureList:{count[x]#x}
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

reorder:{[expressions]
	if[not 99h=type expressions;
		show "invalid input";
		'bad_input
		];
	reordered:expressions shuffle/key expressions;
	key reordered
	}

show "reorder[s]~`b`c`d`a`e"
show reorder[s]~`b`c`d`a`e
