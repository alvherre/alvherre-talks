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

  % Table 0 (the "log table")
  createtable(2, 2);
  setheader(0, "pk");
  setheader(1, "row");
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "ROW(1, 'REJECTED')");

  setcolumn(1, 0, "3");
  setcolumn(1, 1, "ROW(3, 'PENDING')");

  table[0].ll = (0, 0);

  % Table 1 - the new table, now loaded.
  createtable(3, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");

  setcolumn(1, 0, "2");
  setcolumn(1, 1, "RESOLVED");

  setcolumn(2, 0, "3");
  setcolumn(2, 1, "NEW");

  table[1].ul + (0, 5objspacing) = table[0].ll;

  % Transition to table 2.
  createcmd("\vbox{\hbox{UPDATE issues}\hbox{SET state='REJECTED'}\hbox{WHERE id=1;}}");
  % The command box is located in between the original and the new version of
  % the table.
  xpart(cmd[0].ul - table[1].ur) = xpart(table[2].ul - cmd[0].ur);
  % Vertical position is in the middle of the longest table.
  ypart(table[3].ul - cmd[0].ul) = ypart(cmd[0].ll - table[3].ll);

  % Table 2 - the new table with one change applied.
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

  table[2].row[3].highlighted := true;
  table[1].ur + (spacingx, 0) = table[2].ul;

  % Transition to table 3.
  createcmd("\vbox{\hbox{UPDATE issues}\hbox{SET state='PENDING'}\hbox{WHERE id=3;}}");
  xpart(cmd[1].ul - table[2].ur) = xpart(table[3].ul - cmd[1].ur);
  ypart(table[3].ul - cmd[1].ul) = ypart(cmd[1].ll - table[3].ll);

  % Table 3 - the new table with two changes applied.
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

  table[3].row[3].highlighted := true;
  table[3].row[4].highlighted := true;
  table[2].ur + (spacingx, 0) = table[3].ul;

  % Transition to table 4.
  createcmd("\vbox{\hbox{INSERT INTO}\hbox{issues(id, state)}\hbox{VALUES(5, 'NEW');}}");
  xpart(cmd[2].ul - table[3].ur) = xpart(table[4].ul - cmd[2].ur);
  ypart(table[3].ul - cmd[2].ul) = ypart(cmd[2].ll - table[3].ll);

  % Table 4 - the new table with 3 changes applied.
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

  table[4].row[4].highlighted := true;
  table[4].row[5].highlighted := true;
  table[4].row[6].highlighted := true;
  table[3].ur + (spacingx, 0) = table[4].ul;

  finalizetables;
  finalizecmds;

  % Label 0.
  createlabelbig("Time");
  label[0].textonly := true;
  % The arrow will start in the Lower left corner of the picture (see below),
  % so the label is shifted by 'tbborder' upwards.
  label[0].ll = ((xpart table[0].ll, ypart table[3].lr) + (0, tbborder));

  % Label 1.
  createlabelbig("New table loaded");
  label[1].ll = (table[1].ul + (0, objspacing));
  label[1].textonly := true;

  % Label 2.
  createlabelbig("Log table");
  label[2].ul = (table[0].ll - (0, objspacing));
  label[2].textonly := true;

  % Label 3.
  createlabelbig("Data changes are applied to the new table");
  xpart label[3].right = xpart table[3].right;
  ypart label[3].left = ypart table[0].left;
  label[3].textonly := true;

  finalizelabels;

  % TODO Adjust
  initboundingbox((xpart table[0].ll, ypart table[3].ll))((xpart table[3].ur + objspacing, ypart table[0].ul));
  computescalefactor(metapg.bbox);

  adjustpens;
  fixpicturewidth;

  % The original version had more tables. Renumbering would be difficult, so
  % only draw the tables we need now and do other minor adjustments.
  drawtable(0);
  drawtable(1);
  drawtable(2);
  drawtable(3);

  % Like above.
  drawcmd(0);
  drawcmd(1);

  drawlabels;

  pickup arrowpen;

  % Time
  drawarrow (xpart table[0].ll, ypart table[3].lr)--(xpart table[0].ll, ypart table[3].lr) + (5objspacing, 0);

  % Arrows from the log table rows to the commands.
  drawarrow table[0].row[0].right{right}...{down}cmd[0].upper;
  drawarrow table[0].row[1].right{right}...{down}cmd[1].upper;

  % Arrows from the SQL commands to the rows affected.
  drawarrow cmd[0].right{(1, 1)}...{right}table[2].row[0].left;
  drawarrow cmd[1].right{right}...{right}table[3].row[2].left;

  % Arrows from the old tuple versions to the new ones.
  drawarrow table[2].row[0].right{(1, -1)}...{(-1, -1)}table[2].row[3].right;
  drawarrow table[3].row[0].right{(1, -1)}...{(-1, -1)}table[3].row[3].right;
  drawarrow table[3].row[2].right{right}...{left}table[3].row[4].right;

  drawboundingboxwhite;
endfig;
end
