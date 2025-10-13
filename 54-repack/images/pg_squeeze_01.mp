input TEX;
input "metapostgres/common";
input "metapostgres/repack";

hppp := 0.2;
vppp := 0.2;
outputformatoptions := "format=rgb";

prologues := 3;

beginfig(1);
  numeric	spacingx;
  picture	cmd[];

  spacingx := 7objspacing;

  % Table 0
  createtable(4, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "RESOLVED");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "RESOLVED");

  setcolumn(3, 0, "4");
  setcolumn(3, 1, "NEW");

  table[0].ll = (0, 0);

  % Transition to table 1.
  createcmd("\vbox{\hbox{UPDATE issues}\hbox{SET state='REJECTED'}\hbox{WHERE id=1;}}");
  % The command box is located in between the original and the new version of
  % the table.
  xpart(cmd[0].ul - table[0].ur) = xpart(table[1].ul - cmd[0].ur);
  % Vertical position is in the middle of the longest table.
  ypart(table[3].ul - cmd[0].ul) = ypart(cmd[0].ll - table[3].ll);

  createwalrecord("\vbox{\hbox{UPDATE}\vskip1em\hbox{xid=1011}\hbox{tid=(0, 5)}\hbox{tid\_old=(0, 1)}\hbox{value='REJECTED'}}");
  % Horizontally, the WAL records are located between the table versions.
  xpart (walrecords[0].ul - table[0].ur) = xpart (table[1].ul - walrecords[0].ur);

  createwalrecord("\vbox{\hbox{COMMIT}\vskip1em\hbox{xid=1011}}");
  % The commit records are related to the DML ones, so use the minimum space
  % to separate them.
  xpart (walrecords[1].ul - walrecords[0].ur) = objspacing;

  % Table 1
  createtable(5, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "RESOLVED");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "RESOLVED");

  setcolumn(3, 0, "4");
  setcolumn(3, 1, "NEW");

  setcolumn(4, 0, "1");
  setcolumn(4, 1, "REJECTED");

  table[1].row[4].highlighted := true;
  table[0].ur + (spacingx, 0) = table[1].ul;

  % Transition to table 2.
  createcmd("\vbox{\hbox{UPDATE issues}\hbox{SET state='PENDING'}\hbox{WHERE id=4;}}");
  xpart(cmd[1].ul - table[1].ur) = xpart(table[2].ul - cmd[1].ur);
  ypart(table[3].ul - cmd[1].ul) = ypart(cmd[1].ll - table[3].ll);

  createwalrecord("\vbox{\hbox{UPDATE}\vskip1em\hbox{xid=1021}\hbox{tid=(0, 6)}\hbox{tid\_old=(0, 4)}\hbox{value='PENDING'}}");
  % See above.
  xpart (walrecords[2].ul - table[1].ur) = xpart (table[2].ul - walrecords[2].ur);

  createwalrecord("\vbox{\hbox{COMMIT}\vskip1em\hbox{xid=1021}}");
  xpart (walrecords[3].ul - walrecords[2].ur) = objspacing;

  % Table 2
  createtable(6, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "RESOLVED");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "RESOLVED");

  setcolumn(3, 0, "4");
  setcolumn(3, 1, "NEW");

  setcolumn(4, 0, "1");
  setcolumn(4, 1, "REJECTED");

  setcolumn(5, 0, "4");
  setcolumn(5, 1, "PENDING");

  table[2].row[4].highlighted := true;
  table[2].row[5].highlighted := true;
  table[1].ur + (spacingx, 0) = table[2].ul;

  % Transition to table 3.
  createcmd("\vbox{\hbox{INSERT INTO}\hbox{issues(id, state)}\hbox{VALUES(5, 'NEW');}}");
  xpart(cmd[2].ul - table[2].ur) = xpart(table[3].ul - cmd[2].ur);
  ypart(table[3].ul - cmd[2].ul) = ypart(cmd[2].ll - table[3].ll);

  createwalrecord("\vbox{\hbox{INSERT}\vskip1em\hbox{xid=1049}\hbox{tid=(0, 7)}\hbox{value='NEW'}}");
  % See above.
  xpart (walrecords[4].ul - table[2].ur) = xpart (table[3].ul - walrecords[4].ur);

  createwalrecord("\vbox{\hbox{COMMIT}\vskip1em\hbox{xid=1049}}");
  xpart (walrecords[5].ul - walrecords[4].ur) = objspacing;

  % Table 3
  createtable(7, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "RESOLVED");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "RESOLVED");

  setcolumn(3, 0, "4");
  setcolumn(3, 1, "NEW");

  setcolumn(4, 0, "1");
  setcolumn(4, 1, "REJECTED");

  setcolumn(5, 0, "4");
  setcolumn(5, 1, "PENDING");

  setcolumn(6, 0, "5");
  setcolumn(6, 1, "NEW");

  table[3].row[4].highlighted := true;
  table[3].row[5].highlighted := true;
  table[3].row[6].highlighted := true;
  table[2].ur + (spacingx, 0) = table[3].ul;

  finalizetables;
  finalizecmds;
  finalizewal;

  % Table 3 is the longest one, so the vertical position of the WAL rectangle
  % must be controlled by this one.
  wal.ul = (xpart table[0].ll, ypart table[3].lr) - (0, objspacing);
  wal.ur = table[3].lr - (0, objspacing);

  % Label 0.
  createlabelbig("LSN (time)");
  label[0].textonly := true;
  % 'tbborder' above the arrow, see below.
  label[0].ll = (wal.ll + (objspacing, -2objspacing + tbborder));

  finalizelabels;

  initboundingbox(wal.ll - (0, 2objspacing))(table[3].ur + (objspacing, 0));
  computescalefactor(metapg.bbox);

  adjustpens;
  fixpicturewidth;

  drawtables;
  drawlabels;

  pickup arrowpen;
  % Draw arrows from the old tuple versions to the new ones.
  drawarrow table[1].row[0].right{(1, -1)}...{(-1, -1)}table[1].row[4].right;
  drawarrow table[2].row[0].right{(1, -1)}...{(-1, -1)}table[2].row[4].right;
  drawarrow table[2].row[3].right{right}...{left}table[2].row[5].right;
  drawarrow table[3].row[0].right{(1, -1)}...{(-1, -1)}table[3].row[4].right;
  drawarrow table[3].row[3].right{right}...{left}table[3].row[5].right;

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

  drawarrow cmd[1].right{right}...{right}table[2].row[3].left;
  drawarrow cmd[1].lower...walrecords[2].upper;

  drawarrow cmd[2].right{right}...{right}table[3].row[6].left;
  drawarrow cmd[2].lower...walrecords[4].upper;

  %drawboundingbox;
endfig;
end
