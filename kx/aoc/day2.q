input:read0 `:input.txt

.answer.part1:prd sum each flip (2 3 in count each group@) each input

.answer.part2:first[r] where (=/)r:input where any each input{(count[x]-1)=sum not (deltas `int$(x;y))[1;]}/:\:input

