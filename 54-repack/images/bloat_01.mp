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

  table[0].row[4].highlighted := true;
  table[0].row[5].highlighted := true;
  table[0].row[6].highlighted := true;
  table[0].ll = (0, 0);

  finalizetables;

  % Label 0.
  createlabelbig("The old tuple versions will be removed");
  label[0].ll = table[0].row[2].right + (5objspacing, 0);
  label[0].textonly := true;
  % wrap the text by moving it to a separate label
  createlabelbig("by VACUUM");
  label[1].ll := table[0].row[2].right + (5objspacing, -1objspacing);
  label[1].textonly := true;

  finalizelabels;

  % Add space corresponding to half of the table height both above and below
  % the table, so that the bounding box height is similar to that of other
  % pictures (the other pictures depict two rows of tables).
  % initboundingbox(table[0].ll - (table[0].left - table[0].ll))
  %   ((xpart label[0].right,
  % 	ypart table[0].ur) + (table[0].right - table[0].lr));

  initboundingbox(table[0].ll)((xpart label[0].right, ypart table[0].ur));
  computescalefactor(metapg.bbox);

  adjustpens;
  fixpicturewidth;

  drawtables;
  drawlabels;

  % Make sure the picture does contain the bounding box. Without that, the
  % picture contents might be scaled too much, as if there was no bounding
  % box.
  drawboundingboxwhite;

  pickup arrowpen;
  % Arrows to new row versions.
  drawarrow table[0].row[0].right{(1, -1)}...{(-1, -1)}table[0].row[4].right;
  drawarrow table[0].row[1].right{(2, -1)}...{(-2, -1)}table[0].row[5].right;
  drawarrow table[0].row[3].right{(1, -1)}...{(-1, -1)}table[0].row[6].right;

  % Arrows from the label to the new row versions.
  drawarrow label[0].left...table[0].row[0].right + (objspacing, 0);
  drawarrow label[0].left...table[0].row[1].right + (objspacing, 0);
  drawarrow label[0].left...table[0].row[3].right + (objspacing, 0);

  %drawboundingbox;
endfig;
end
