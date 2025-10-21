input TEX;
input "metapostgres/common";
input "metapostgres/table";

hppp := 0.2;
vppp := 0.2;
outputformatoptions := "format=rgb";

prologues := 3;

beginfig(1);
  % Table 0
  createtable(4, 3);
  setcolalignments(r,l,r);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "Pear");
  setcolumn(0, 2, "150");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "Macrosaft");
  setcolumn(1, 2, "1024");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "Diviner");
  setcolumn(2, 2, "543");

  setcolumn(3, 0, "4");
  setcolumn(3, 1, "Googol");
  setcolumn(3, 2, "99");

  table[0].row[0].highlighted := true;
  table[0].row[1].highlighted := true;
  table[0].row[3].highlighted := true;
  table[0].ll = (0, 0);

  createlabelbig("table: companies");
  %label[0].ll = table[0].row[0].left + (0, objspacing);
  label[0].lower = table[0].upper + (0, 0.5objspacing);
  label[0].textonly := true;

  createtable(4, 3);
  setcolalignments(r,l,r);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "Pear");
  setcolumn(0, 2, "120");
  setcolumn(1, 0, "2");
  setcolumn(1, 1, "Macrosaft");
  setcolumn(1, 2, "988");
  setcolumn(2, 0, "4");
  setcolumn(2, 1, "Googol");
  setcolumn(2, 2, "12");

  % Dummy data to adjust the table width.
  setcolumn(3, 0, "4");
  setcolumn(3, 1, "RESOLVED");
  table[1].ll = (300, 0);
  table[1].row[3].hidden := true;

  createlabelbig("Rollback segment");
  %label[1].ll = table[1].row[0].left + (0, objspacing);
  label[1].lower = table[1].upper + (0, 0.5objspacing);
  label[1].textonly := true;

  finalizetables;

  finalizelabels;

  % Add space corresponding to half of the table height both above and below
  % the table, so that the bounding box height is similar to that of other
  % pictures (the other pictures depict two rows of tables).
  % initboundingbox(table[0].ll - (table[0].left - table[0].ll))
  %   ((xpart label[0].right,
  % 	ypart table[0].ur) + (table[0].right - table[0].lr));

  initboundingbox(table[0].ll)(label[1].ur);
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
  % Arrows to row versions in rollback segment.
  % drawarrow table[0].row[0].right{(1, 0.5)}...{(1, 1)}table[1].row[0].left;
  % drawarrow table[0].row[1].right{(2, 0.3)}...{(2, 1)}table[1].row[1].left;
  % drawarrow table[0].row[3].right{(1, 0.1)}...{(1, 1)}table[1].row[2].left;
  drawarrow table[0].row[0].right...table[1].row[0].left;
  drawarrow table[0].row[1].right...table[1].row[1].left;
  drawarrow table[0].row[3].right...table[1].row[2].left;

  %drawboundingbox;
endfig;
end
