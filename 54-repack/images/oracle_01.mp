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
  setcolumn(0, 2, "120");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "Macrosaft");
  setcolumn(1, 2, "988");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "Diviner");
  setcolumn(2, 2, "543");

  setcolumn(3, 0, "4");
  setcolumn(3, 1, "Googol");
  setcolumn(3, 2, "12");

  table[0].ll = (0, 0);

  createlabelbig("table: companies");
  %label[0].ll = table[0].row[0].left + (0, objspacing);
  label[0].lower = table[0].upper + (0, 0.5objspacing);
  label[0].textonly := true;

  createtable(4, 3);
  setcolalignments(r,l,r);

  % Dummy data to achieve "normal" width of the table.
  setcolumn(0, 0, "1");
  setcolumn(1, 1, "Macrosaft");
  setcolumn(1, 2, "988");

  table[1].ll = (300, 0);
  table[1].row[0].hidden := true;
  table[1].row[1].hidden := true;
  table[1].row[2].hidden := true;
  table[1].row[3].hidden := true;

  createlabelbig("Rollback segment");
  %label[1].ll = table[1].row[0].left + (0, objspacing);
  label[1].lower = table[1].upper + (0, 0.5objspacing);
  label[1].textonly := true;

  finalizetables;

%  createlabelbig("The old tuple versions will be removed by VACUUM");
%  label[0].ll = table[0].row[2].right + (5objspacing, 0);
%  label[0].textonly := true;

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

  %drawboundingbox;
endfig;
end
