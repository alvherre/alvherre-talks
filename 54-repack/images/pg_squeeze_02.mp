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
  picture	descr[];
  pair		descr[].shift;

  spacingx := 7objspacing;

  % This picture is derived from pg_squeeze_01, but we don't need some of its
  % tables and commands here. Since the position of other components is
  % derived from them, it's easier to define even those we don't want and mark
  % them as "hidden" (placeholders) than to define a new set of equations.

  % Table 0
  createtable(4, 2);
  % This table is only a placeholder now.
  table[0].hidden := true;

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

  %createwalrecord("\vbox{\hbox{COMMIT}\vskip1em\hbox{xid=1011}}");
  % The commit records are related to the DML ones, so use the minimum space
  % to separate them.
  %xpart (walrecords[1].ul - walrecords[0].ur) = objspacing;

  % Table 1
  createtable(5, 2);
  % This table is only a placeholder now.
  table[1].hidden := true;

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

  %table[1].row[0].highlighted := true;
  table[0].ur + (spacingx, 0) = table[1].ul;

  % Transition to table 2.
  createcmd("\vbox{\hbox{UPDATE issues}\hbox{SET state='PENDING'}\hbox{WHERE id=4;}}");
  xpart(cmd[1].ul - table[1].ur) = xpart(table[2].ul - cmd[1].ur);
  ypart(table[3].ul - cmd[1].ul) = ypart(cmd[1].ll - table[3].ll);

  createwalrecord("\vbox{\hbox{UPDATE}\vskip1em\hbox{xid=1021}\hbox{tid=(0, 6)}\hbox{tid\_old=(0, 4)}\hbox{value='PENDING'}}");
  % See above.
  xpart (walrecords[1].ul - table[1].ur) = xpart (table[2].ul - walrecords[1].ur);

  % createwalrecord("\vbox{\hbox{COMMIT}\vskip1em\hbox{xid=1021}}");
  % xpart (walrecords[3].ul - walrecords[2].ur) = objspacing;

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

  % createwalrecord("\vbox{\hbox{COMMIT}\vskip1em\hbox{xid=1049}}");
  % xpart (walrecords[5].ul - walrecords[4].ur) = objspacing;

  % Table 3
  %
  % Note: not used anymore, but I didn't want to perform renumbering.
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

  % Highlight the rows not visible to the initial snapshot.
  table[3].row[4].highlighted := true;
  table[3].row[5].highlighted := true;
  table[3].row[6].highlighted := true;
  table[2].ur + (spacingx, 0) = table[3].ul;

  % Table 4 - identical to table 0.
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

  xpart table[4].ul = xpart table[0].ul;
  ypart table[4].ul = ypart wal.ll - 5objspacing;

  finalizetables;
  finalizewal;
  finalizecmds;

  % Label 0.
  createlabelbig("Scan using the initial snapshot");
  % Label 1.
  createlabelbig("Insert matching tuples into the new table");

  label[0].ur = (xpart wal.lr, ypart wal.lr  - 3objspacing);

  xpart label[1].ll = xpart table[4].ur;
  ypart label[1].lr = ypart label[0].lr;

  % Label 2.
  createlabelbig("LSN (time)");
  label[2].textonly := true;
  % 'tbborder' above the arrow, see below.
  label[2].ll = (wal.ll + (objspacing, -2objspacing + tbborder));

  finalizelabels;

  % Table 2 is the longest one, so the vertical position of the WAL rectangle
  % must be controlled by this one.
  wal.ul = (xpart table[0].ll, ypart table[2].lr) - (0, objspacing);
  wal.ur = table[2].lr - (0, objspacing);

  initboundingbox(table[4].ll)(table[2].ur + (objspacing, 0));
  computescalefactor(metapg.bbox);

  adjustpens;
  fixpicturewidth;

  % The original version had more tables. Renumbering would be difficult, so
  % only draw the tables we need now and do other minor adjustments.
  drawtable(2);
  drawtable(4);

  pickup arrowpen;
  % Draw arrows from the old tuple versions to the new ones.
  drawarrow table[2].row[0].right{(1, -1)}...{(-1, -1)}table[2].row[4].right;
  drawarrow table[2].row[3].right{right}...{left}table[2].row[5].right;

  drawwal;

  % The direction of LSN. XXX What's the appropriate length of the arrow?
  drawarrow wal.ll + (objspacing, -2objspacing)--(xpart walrecords[0].ll, ypart wal.ll - 2objspacing);

  % Mark the initial WAL position for decoding. It just make sense to align it
  % with the right edge of the first table.
  draw (xpart table[0].lr, ypart wal.ul)--(xpart table[0].lr, ypart wal.ll);

  % Label is not used here because it does not fit into a single line.
  descr[0] := TEX (setfntstrdescr &
      "\vbox{\hbox{Logical decoding starts here}\vskip1em\hbox{The initial snapshot does not see the effects}\hbox{of the transactions committed after this point}}");
  descr[0].shift := table[0].lr;
  draw descr[0] shifted descr[0].shift;
  % Arrow pointing to the WAL start position.
  drawarrow (table[0].lr - (0, objspacing))--((xpart table[0].lr, ypart wal.ul) + (0, objspacing));
  % Arrows pointing to the tuples not visible to the initial snapshots.
  drawarrow (lrcorner descr[0] + descr[0].shift)--table[2].row[4].left;
  drawarrow (lrcorner descr[0] + descr[0].shift)--table[2].row[5].left;

  drawlabels;

  % Arrow from the "scan label" to the old table.
  drawarrow (xpart table[2].lower, ypart label[0].ur)--table[2].lower;
  % Arrow from the scan to the insert.
  drawarrow label[0].left--label[1].right;
  % Arrow from the insert to the new table.
  drawarrow label[1].left{left}...{down}table[4].upper;

  drawboundingboxwhite;
endfig;
end
