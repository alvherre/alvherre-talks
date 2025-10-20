input TEX;
input "metapostgres/common";
input "metapostgres/table";

hppp := 0.2;
vppp := 0.2;
outputformatoptions := "format=rgb";

prologues := 3;

beginfig(1);
  picture	descr[];
  pair		descr[].shift, descr[].left, descr[].right, descr[].upper;
  numeric	descr[].height, descr[].width;

  % Table 0
  createtable(8, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "3");
  setcolumn(0, 1, "RESOLVED");

  setcolumn(1, 0, "");
  setcolumn(1, 1, "");

  setcolumn(2, 0, "1");
  setcolumn(2, 1, "NEW");

  setcolumn(3, 0, "");
  setcolumn(3, 1, "");

  setcolumn(4, 0, "");
  setcolumn(4, 1, "");

  setcolumn(5, 0, "4");
  setcolumn(5, 1, "NEW");

  setcolumn(6, 0, "");
  setcolumn(6, 1, "");

  setcolumn(7, 0, "2");
  setcolumn(7, 1, "PENDING");

  table[0].row[1].hidden := true;
  table[0].row[3].hidden := true;
  table[0].row[4].hidden := true;
  table[0].row[6].hidden := true;

  % Table 1
  createtable(4, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "3");
  setcolumn(0, 1, "RESOLVED");

  setcolumn(1, 0, "1");
  setcolumn(1, 1, "NEW");

  setcolumn(2, 0, "4");
  setcolumn(2, 1, "NEW");

  setcolumn(3, 0, "2");
  setcolumn(3, 1, "PENDING");

  table[1].row[2].hidden := true;
  table[1].row[3].hidden := true;
  table[1].row[4].hidden := true;

  table[0].ll = (0, 0);
  table[0].ur + (3objspacing, 0) = table[1].ul;

  createlabel("issues");
  label[0].lower - (0, objspacing) = table[0].upper;
  createlabel("pg\_temp\_23183");
  label[1].lower - (0, objspacing) = table[1].upper;

  finalizetables;
  finalizelabels;

  % Add space corresponding to half of the table height both above and below
  % the table, so that the bounding box height is similar to that of other
  % pictures (the other pictures depict two rows of tables).
  %initboundingbox(table[0].ll)((xpart table[1].right, ypart label[1].upper));

  initboundingbox(table[0].ll)(label[1].ur);

  computescalefactor(metapg.bbox);
  adjustpens;
  fixpicturewidth;

  drawtables;
  drawlabels;

  % Arrows that indicate tuple copying.
  drawarrow table[0].row[0].right--table[1].row[0].left;
  drawarrow table[0].row[2].right--table[1].row[1].left;

  drawboundingboxwhite;
endfig;
end
