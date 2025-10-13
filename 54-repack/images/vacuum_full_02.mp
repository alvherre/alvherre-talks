input TEX;
input "metapostgres/common";
input "metapostgres/repack";

hppp := 0.2;
vppp := 0.2;
outputformatoptions := "format=rgb";

prologues := 3;

beginfig(1);
  picture	descr[];
  pair		descr[].shift;

  % Table 0
  createtable(7, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "NEW");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "RESOLVED");

  setcolumn(3, 0, "4");
  setcolumn(3, 1, "NEW");

  setcolumn(4, 0, "1");
  setcolumn(4, 1, "REJECTED");

  setcolumn(5, 0, "2");
  setcolumn(5, 1, "PENDING");

  setcolumn(6, 0, "4");
  setcolumn(6, 1, "RESOLVED");

  table[0].row[0].hidden := true;
  table[0].row[1].hidden := true;
  table[0].row[3].hidden := true;

  % Table 1
  createtable(4, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "3");
  setcolumn(0, 1, "RESOLVED");

  setcolumn(1, 0, "1");
  setcolumn(1, 1, "REJECTED");

  setcolumn(2, 0, "2");
  setcolumn(2, 1, "PENDING");

  setcolumn(3, 0, "4");
  setcolumn(3, 1, "RESOLVED");

  table[0].ll = (0, 0);
  table[0].ur + (7objspacing, 0) = table[1].ul;

  finalizetables;

  % Label 0.
  createlabel("issues");
  label[0].lower - (0, objspacing) = table[0].upper;
  % Label 1.
  createlabel("pg\_temp\_23183");
  label[1].lower - (0, objspacing) = table[1].upper;
  % Label 2.
  createlabelbig("Swap file pointers");
  label[2].textonly := true;
  % Vertically the position of the first row of table[1]. Horizontally,
  % leading and trailing space should be equal.
  label[2].ll =
    ((xpart table[0].right, ypart table[1].row[0].lower) +
      (.5(xpart (table[1].left - table[0].right - (label[2].right - label[2].left))), 0));

  finalizelabels;

  % Add space corresponding to half of the table height both above and below
  % the table, so that the bounding box height is similar to that of other
  % pictures (the other pictures depict two rows of tables).
  % initboundingbox(table[0].ll - (table[0].left - table[0].ll))
  %   ((xpart table[1].ur, ypart (label[1].ur + table[0].right - table[0].lr)));

  initboundingbox(table[0].ll)((xpart label[0].right, ypart label[1].upper));
  computescalefactor(metapg.bbox);
  adjustpens;
  fixpicturewidth;

  drawtables;

  % Draw and fill the labels.
  fill label[0].ll--label[0].lr--label[0].ur--label[0].ul--cycle withcolor tablehdrbgcolor;
  fill label[1].ll--label[1].lr--label[1].ur--label[1].ul--cycle withcolor tablehdrbgcolor;
  drawlabels;

  pickup arrowpen;

  % Pointers to relfilenodes.
  drawarrow label[0].lower--table[1].upper;
  drawarrow label[1].lower--table[0].upper;

  %drawarrow (xpart table[0].right, ypart table[1].left)..table[1].left;

  drawboundingboxwhite;
endfig;
end

