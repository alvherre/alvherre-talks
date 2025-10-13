input TEX;
input "metapostgres/common";
input "metapostgres/repack";

hppp := 0.2;
vppp := 0.2;
outputformatoptions := "format=rgb";

prologues := 3;

beginfig(1);
  % Table 0
  createtable(4, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "NEW");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "RESOLVED");

  setcolumn(3, 0, "4");
  setcolumn(3, 1, "NEW");

  table[0].ll = (0, 0);

  createtable(4, 2);
  % How can I make this box wider?
  setcolalignments(r,l);
  table[1].ll = (300, 0);
  table[1].row[0].hidden := true;
  table[1].row[1].hidden := true;
  table[1].row[2].hidden := true;
  table[1].row[3].hidden := true;

  createlabelbig("Rollback segment");
  label[0].ll = table[1].row[0].left + (0, objspacing);
  label[0].textonly := true;

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

  initboundingbox(table[0].ll)((xpart table[1].right, ypart table[0].ur));
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
