input TEX;
input "metapostgres/common";
input "metapostgres/table";

hppp := 0.2;
vppp := 0.2;
outputformatoptions := "format=rgb";

prologues := 3;

beginfig(1);
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
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "REJECTED");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "PENDING");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "RESOLVED");

  setcolumn(3, 0, "4");
  setcolumn(3, 1, "RESOLVED");

  table[0].ll = (0, 0);
  xpart table[0].ur + 7objspacing = xpart table[1].ul;
  ypart (table[0].ul - table[1].ul) = ypart (table[1].ll - table[0].ll);

  finalizetables;

  % Label 0.
  createlabelbig("CLUSTER");
  label[0].textonly := true;
  % Leading and trailing space should be equal.
  label[0].ll =
    (table[0].right +
      (.5(xpart (table[1].left - table[0].right - (label[0].right - label[0].left))),
	tbcellspacingy));
  finalizelabels;

  % Add space corresponding to half of the table height both above and below
  % the table, so that the bounding box height is similar to that of other
  % pictures (the other pictures depict two rows of tables).
  % initboundingbox(table[0].ll - (table[0].left - table[0].ll))
  %   ((xpart table[1].ur, ypart table[0].ur) + (table[0].right - table[0].lr));

  initboundingbox(table[0].ll)((xpart table[1].right, ypart table[0].upper));
  computescalefactor(metapg.bbox);
  adjustpens;
  fixpicturewidth;

  drawtables;
  drawlabels;

  pickup arrowpen;
  drawarrow table[0].right..table[1].left;

  % Make sure the picture does contain the bounding box. Without that, the
  % picture contents might be scaled too much, as if there was no bounding
  % box.
  drawboundingboxwhite;
endfig;
end

