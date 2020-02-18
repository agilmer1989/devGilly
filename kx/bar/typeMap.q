typeMap:{[]                                                                                 map:{[char]                                                                                 / upper case return type casted list , lower case return null
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


show typeMap[]
