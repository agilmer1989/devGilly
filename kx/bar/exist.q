/setup
a:10

exists:{[variable]
        if[isVariable:variable in system"v";:1b];
        if[isFunction:variable in system"f";:1b];
        if[isContext:variable in key `;:1b];
        if[isView:variable in views[];:1b];
        isDefined:not `not_defined~@[value;variable;`not_defined];
        isDefined
        }

show "exists `a"
show exists `a

show "exists `b"
show exists `b

show "exists `.q"
show exists `.q
