.util.getType:{[tbl]$[1<abs type b:.Q.qp value tbl;`flat;1h$b;`disk;`splay]}
.util.getFn:{(first 2_(.Q.btx .Q.Ll`)[;1;0]),":"}
.util.cleandb:{[db](system "unlink ",.types.fstr .Q.dd[db]@) each where not f!(count key hsym@) each f:key db}
.util.systemtz:`$raze system"timedatectl | grep 'Time zone' | awk -F' ' '{print $3}'"

