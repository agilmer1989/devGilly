.util.getType:{[tbl]$[1<abs type b:.Q.qp value tbl;`flat;1h$b;`disk;`splay]}
.util.getFn:{(first 2_(.Q.btx .Q.Ll`)[;1;0]),":"}
.util.cleandb:{[db](system "unlink ",.types.fstr .Q.dd[db]@) each where not f!(count key hsym@) each f:key db}
.util.systemtz:`$raze system"timedatectl | grep 'Time zone' | awk -F' ' '{print $3}'"
.util.applyMap:{[tbl;map]cols[tbl]^map cols tbl}
.util.cap:@[;0;upper]
.util.loadrel:{system"l ","/"sv(-1_("/\\""w"~first string .z.o)vs(reverse value x)2),enlist x[]}
.util.numericformat: {n:x<0;$[n;"-";""],"." sv @[;0;{reverse "," sv 3 cut reverse x}] "." vs .Q.f[2;abs x]}

/@param x (tuple) screen ratio to set console size to i.e. 0.5 1 = half hte console rows, full console width 
.util.console:{system"c ",.Q.s1 ceiling x*"J"$" " vs first system"stty size"}

 

