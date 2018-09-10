/ Convert kdb dictionary to pretty formatted json file, using python json.tool
/ @param f (filehandle) location of file to write to
/ @param d (dictionary) Data object to be converted
prettyjson:{[f;d]
  system"rm -f ",1_string hsym f;
  h:hopen f;hclose h .j.j d;
  f 0:system"cat ",(1_string hsym f),"| python -m json.tool"
  }

/ prettyjson[`:test.json;d]
