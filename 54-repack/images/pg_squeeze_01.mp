input TEX;
input "metapostgres/common";
input "metapostgres/table";

hppp := 0.2;
vppp := 0.2;
outputformatoptions := "format=rgb";

prologues := 3;

beginfig(1);
  numeric	spacingx;
  picture	cmd[];

  spacingx := 7objspacing;

  % Table 0
  createtable(3, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "RESOLVED");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "NEW");

  table[0].ll = (0, 0);

  % Transition to table 1.
  createcmd("\vbox{\hbox{UPDATE issues}\hbox{SET state='REJECTED'}\hbox{WHERE id=1;}}");
  % The command box is located in between the original and the new version of
  % the table.
  xpart(cmd[0].ul - table[0].ur) = xpart(table[1].ul - cmd[0].ur);
  % Vertical position is in the middle of the longest table.
  ypart(table[2].ul - cmd[0].ul) = ypart(cmd[0].ll - table[2].ll);

  createwalrecord("\vbox{\hbox{UPDATE}\vskip1em\hbox{xid=1011}\hbox{tid=(0, 4)}\hbox{tid\_old=(0, 1)}\hbox{value='REJECTED'}}");
  % Horizontally, the WAL records are located between the table versions.
  xpart (walrecords[0].ul - table[0].ur) = xpart (table[1].ul - walrecords[0].ur);

  % Table 1
  createtable(4, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "RESOLVED");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "NEW");

  setcolumn(3, 0, "1");
  setcolumn(3, 1, "REJECTED");

  table[1].row[3].highlighted := true;
  table[0].ur + (spacingx, 0) = table[1].ul;

  % Transition to table 2.
  createcmd("\vbox{\hbox{UPDATE issues}\hbox{SET state='PENDING'}\hbox{WHERE id=3;}}");
  xpart(cmd[1].ul - table[1].ur) = xpart(table[2].ul - cmd[1].ur);
  ypart(table[2].ul - cmd[1].ul) = ypart(cmd[1].ll - table[2].ll);

  createwalrecord("\vbox{\hbox{UPDATE}\vskip1em\hbox{xid=1021}\hbox{tid=(0, 5)}\hbox{tid\_old=(0, 3)}\hbox{value='PENDING'}}");
  % See above.
  xpart (walrecords[1].ul - table[1].ur) = xpart (table[2].ul - walrecords[1].ur);

  % Table 2
  createtable(5, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "RESOLVED");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "NEW");

  setcolumn(3, 0, "1");
  setcolumn(3, 1, "REJECTED");

  setcolumn(4, 0, "3");
  setcolumn(4, 1, "PENDING");

  table[2].row[3].highlighted := true;
  table[2].row[4].highlighted := true;
  table[1].ur + (spacingx, 0) = table[2].ul;

  finalizetables;
  finalizecmds;
  finalizewal;

  % Table 3 is the longest one, so the vertical position of the WAL rectangle
  % must be controlled by this one.
  wal.ul = (xpart table[0].ll, ypart table[2].lr) - (0, objspacing);
  wal.ur = table[2].lr - (0, objspacing);

  % Label 0.
  createlabelbig("LSN (time)");
  label[0].textonly := true;
  % 'tbborder' above the arrow, see below.
  label[0].ll = (wal.ll + (objspacing, -2objspacing + tbborder));

  finalizelabels;

  initboundingbox(wal.ll - (0, 2objspacing))(table[2].ur + (objspacing, 0));
  computescalefactor(metapg.bbox);

  adjustpens;
  fixpicturewidth;

  drawtables;
  drawlabels;

  pickup arrowpen;
  % Draw arrows from the old tuple versions to the new ones.
  drawarrow table[1].row[0].right{(1, -1)}...{(-1, -1)}table[1].row[3].right;
  drawarrow table[2].row[0].right{(1, -1)}...{(-1, -1)}table[2].row[3].right;
  drawarrow table[2].row[2].right{right}...{left}table[2].row[4].right;

  drawwal;
  % The direction of LSN. XXX What's the appropriate length of the arrow?
  drawarrow wal.ll + (objspacing, -2objspacing)--(xpart walrecords[0].ll, ypart wal.ll - 2objspacing);

  drawcmds;

  % Finally, draw arrows from each SQL command to the resulting row as well as
  % to the corresponding WAL record. Besides the fact that adjustpens must
  % have been called, we should not do it before filling the rectangles
  % (because that would overwrite parts of the arrows).
  pickup arrowpen;
  drawarrow cmd[0].right{(1, 1)}...{right}table[1].row[0].left;
  drawarrow cmd[0].lower...walrecords[0].upper;

  drawarrow cmd[1].right{right}...{right}table[2].row[2].left;
  drawarrow cmd[1].lower...walrecords[1].upper;

  drawboundingboxwhite;
endfig;
end
