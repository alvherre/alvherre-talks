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

  % In this picture, most of the tables are depicted below the WAL area.
  table[0].ll = (0, 0);
  table[0].ul + (0, 5objspacing) = wal.ll;

  % Transition to table 1.
  createcmd("heap\_update(...)");
  % The command box is located in between the original and the new version of
  % the table.
  xpart(cmd[0].ul - table[0].ur) = xpart(table[1].ul - cmd[0].ur);
  % Vertical position is in the middle of the longest table.
  ypart(table[2].ul - cmd[0].ul) = ypart(cmd[0].ll - table[2].ll);

  createwalrecord("\vbox{\hbox{UPDATE}\vskip1em\hbox{xid=1011}\hbox{tid=(0, 5)}\hbox{tid\_old=(0, 1)}\hbox{value='REJECTED'}}");
  % Horizontally, the WAL records are located between the table versions.
  xpart (walrecords[0].ul - table[0].ur) = xpart (table[1].ul - walrecords[0].ur);

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
  createcmd("heap\_update(...)");
  xpart(cmd[1].ul - table[1].ur) = xpart(table[2].ul - cmd[1].ur);
  ypart(table[2].ul - cmd[1].ul) = ypart(cmd[1].ll - table[2].ll);

  createwalrecord("\vbox{\hbox{UPDATE}\vskip1em\hbox{xid=1021}\hbox{tid=(0, 6)}\hbox{tid\_old=(0, 4)}\hbox{value='PENDING'}}");
  % See above.
  xpart (walrecords[1].ul - table[1].ur) = xpart (table[2].ul - walrecords[1].ur);

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

  % Highlight the rows not visible to the initial snapshot.
  table[2].row[4].highlighted := true;
  table[2].row[5].highlighted := true;
  table[1].ur + (spacingx, 0) = table[2].ul;

  % Table 3 - above table 2.
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

  table[3].row[4].highlighted := true;
  table[3].row[5].highlighted := true;

  xpart table[2].right = xpart table[3].right;

  table[2].ur + (spacingx, 0) = table[4].ul;

  % Label 0.
  createlabelbig("Decode WAL and call heap AM API to apply them the new table");
  label[0].upper = (xpart .5(wal.ll + wal.lr), ypart wal.ll - 2objspacing);

  % Label 1.
  createlabelbig("LSN (time)");
  % 'tbborder' above the arrow, see below.
  label[1].ll = (wal.ul + (objspacing, objspacing + tbborder));
  label[1].textonly := true;

  finalizetables;
  finalizewal;
  finalizecmds;
  finalizelabels;

  % Table 3 is the longest one, so the vertical position of the WAL rectangle
  % must be controlled by this one.
  wal.ur = table[3].lr - (0, objspacing);

  initboundingbox((xpart table[0].ll, ypart table[2].ll))(table[3].ur + (objspacing, 0));
  computescalefactor(metapg.bbox);

  adjustpens;
  fixpicturewidth;

  % The original version had more tables. Renumbering would be difficult, so
  % only draw the tables we need now and do other minor adjustments.
  drawtable(0);
  drawtable(1);
  drawtable(2);
  drawtable(3);

  drawwal;
  drawcmds;
  drawlabels;

  pickup arrowpen;
  % Draw arrows from the old tuple versions to the new ones.
  drawarrow table[1].row[0].right{(1, -1)}...{(-1, -1)}table[1].row[4].right;
  drawarrow table[2].row[0].right{(1, -1)}...{(-1, -1)}table[2].row[4].right;
  drawarrow table[2].row[3].right{right}...{left}table[2].row[5].right;
  % drawarrow table[4].row[0].right{(1, -1)}...{(-1, -1)}table[4].row[4].right;
  % drawarrow table[4].row[3].right{right}...{left}table[4].row[5].right;

  % The direction of LSN. XXX What's the appropriate length of the arrow?
  drawarrow wal.ul + (objspacing, objspacing)--(xpart walrecords[0].ll, ypart wal.ul + objspacing);

  % Mark the initial WAL position for decoding. It just make sense to align it
  % with the right edge of the first table.
  %draw (xpart table[0].lr, ypart wal.ul)--(xpart table[0].lr, ypart wal.ll);

  % Draw arrows from the WAL records to the corresponding commands and also
  % arrows to the resulting rows.
  drawarrow walrecords[0].lower...(xpart walrecords[0].lower, ypart label[0].upper);
  drawarrow (xpart walrecords[0].lower, ypart label[0].lower)...cmd[0].upper;
  drawarrow cmd[0].right{(1, 1)}...{right}table[1].row[0].left;

  drawarrow walrecords[1].lower...(xpart walrecords[1].lower, ypart label[0].upper);
  drawarrow (xpart walrecords[1].lower, ypart label[0].lower)...cmd[1].upper;
  drawarrow cmd[1].right{(1, 1)}...{right}table[2].row[0].left;

  drawboundingboxwhite;
endfig;
end
