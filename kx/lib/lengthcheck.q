 / column length check
lcheck:{[db;tb;dt]
  path:` sv db,(`$string[dt]),tb;
  fl`sv path,.d
  fl:get ` sv/:path,/:c:` sv path,.d;
  hd:`dbdate`column`cnt;
  flip hd!(count[c]#dt;fl;(count get@) peach fl)
  }
