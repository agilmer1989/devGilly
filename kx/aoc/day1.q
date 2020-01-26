"J"$read0 `:input.txt
.answer.part1:sum input

getindex:{
 g:group[x][;1] / find index of first repeating item
 g?min g
 }
 
.answer.part2:getindex 0+\input   /include 0+ instead of just sums

