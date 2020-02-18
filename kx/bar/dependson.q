/ setup

a:10
b::a+1
c::a+2
d:c+20
e::b+d
f::e+4
g::f+5

dependson:{[v]
	except[raze count(raze .z.b@)\v;v]
	}



