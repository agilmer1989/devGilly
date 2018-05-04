prettyjson:{[f;d]
  system"rm ",1_string hsym f;
  h:hopen f;h .j.j d;
  f 0:system"cat ",(1_string hsym f),"| python -m json.tool"
  }

prettyjson[`:ag.json;d]
