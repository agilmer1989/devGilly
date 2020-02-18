/ setup

a:10
b::a+1
c::a+2
d:c+20
e::b+d
f::e+4
g::f+5

dependson:{[v]
	raze count(raze .z.b@)\v
	}

show "dependson `a~`a`b`c`e`f`g"
show dependson[`a]~`a`b`c`e`f`g



