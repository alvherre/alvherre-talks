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

  % Label 0.
  createlabelbig("INSERT INTO ... SELECT ... FROM ...");
  % Horizontally aligned with table 0.
  xpart label[0].ul = xpart table[0].ll;
  % Vertically below the adjacent table so it can be long enough.
  ypart label[0].ul = ypart table[1].ll - objspacing;

  % Label 1.
  createlabelbig("Trigger inserts data changes into log table");
  % Horizontally centered.
  xpart label[1].ul - xpart table[0].ll = xpart table[3].lr - xpart label[1].ur;
  % Vertically below the longest table in the upper part (table 3).
  ypart label[1].ur = ypart table[3].lr - objspacing;

  % Table 4 (the "log table")
  createtable(3, 2);
  setheader(0, "pk");
  setheader(1, "row");
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "ROW(1, 'REJECTED')");

  setcolumn(1, 0, "4");
  setcolumn(1, 1, "ROW(4, 'PENDING')");

  setcolumn(2, 0, "");
  setcolumn(2, 1, "ROW(5, 'NEW')");

  % Horizontally, the log table is in the middle.
  xpart (table[4].ul - table[0].ll) = xpart (table[3].lr - table[4].ur);
  % Vertically below the label.
  ypart table[4].ur = ypart label[1].lr - objspacing;

  % Table 5 - the new table, partially loaded.
  createtable(1, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");

  % Horizontally aligned with table 0.
  xpart table[5].ul = xpart table[0].ll;
  % Vertically just below the "log table".
  ypart table[5].ul = ypart table[4].ll - objspacing;

  % Table 6 - the new table, partially loaded.
  createtable(2, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");
  setcolumn(1, 0, "2");
  setcolumn(1, 1, "RESOLVED");

  % Horizontally aligned with table 1.
  xpart table[6].ul = xpart table[1].ll;
  % Vertically just below the "log table".
  ypart table[6].ul = ypart table[4].ll - objspacing;

  % Table 7 - the new table, partially loaded.
  createtable(3, 2);
  setcolalignments(r,l);
  setcolumn(0, 0, "1");
  setcolumn(0, 1, "NEW");
  setcolumn(1, 0, "2");
  setcolumn(1, 1, "RESOLVED");
  setcolumn(2, 0, "3");
  setcolumn(2, 1, "RESOLVED");

  % Horizontally aligned with table 2.
  xpart table[7].ul = xpart table[2].ll;
  % Vertically just below the "log table".
  ypart table[7].ul = ypart table[4].ll - objspacing;

  % Table 8 - the new table, loaded.
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

  % Horizontally aligned with table 3.
  xpart table[8].ul = xpart table[3].ll;
  % Vertically just below the "log table".
  ypart table[8].ul = ypart table[4].ll - objspacing;

  % Label 2.
  createlabelbig("Old table");
  label[2].textonly := true;
  % Vertically in the middle of table[0], horizontally objspacing between the
  % end of the description and the table.
  label[2].right + (objspacing, 0) = table[0].left;

  % Label 3.
  createlabelbig("New table");
  label[3].textonly := true;
  % Horizontally the same as label[2], vertically in the middle of table[8]
  % (as this one has the full length).
  xpart label[3].left = xpart label[2].left;
  ypart label[3].right = ypart table[5].left;

  % Label 4.
  createlabelbig("Time");
  label[4].textonly := true;
  % The arrow will start in the Lower left corner of the picture (see below),
  % so the label is shifted by 'tbborder' upwards.
  label[4].ll = ((xpart table[5].ll, ypart table[8].lr) + (0, tbborder));

  finalizetables;
  finalizecmds;
  finalizelabels;

  initboundingbox((xpart label[2].left, ypart table[8].ll))((table[3].ur + (objspacing, 0)));
  computescalefactor(metapg.bbox);

  adjustpens;
  fixpicturewidth;

  drawtables;

  pickup arrowpen;
  % Draw arrows from the old tuple versions to the new ones.
  drawarrow table[1].row[0].right{(1, -1)}...{(-1, -1)}table[1].row[4].right;
  drawarrow table[2].row[0].right{(1, -1)}...{(-1, -1)}table[2].row[4].right;
  drawarrow table[2].row[3].right{right}...{left}table[2].row[5].right;
  drawarrow table[3].row[0].right{(1, -1)}...{(-1, -1)}table[3].row[4].right;
  drawarrow table[3].row[3].right{right}...{left}table[3].row[5].right;

  % Show the initial copy.
  drawarrow table[0].lower...(xpart table[0].lower, ypart label[0].upper);
  drawarrow (xpart table[0].lower, ypart label[0].lower)...table[5].upper;

  % Arrows from the new tuples to the log table (via trigger).
  drawarrow table[1].row[4].lower{down}...{down}label[1].upper - (3objspacing, 0);
  drawarrow label[1].lower - (3objspacing, 0){(-4, -1)}...{(4, -1)}table[4].row[0].left;

  drawarrow table[2].row[5].lower{(-1, -1)}...{(-1, -1)}label[1].upper;
  drawarrow label[1].lower{(4, -.3)}...{(-3, -.5)}table[4].row[1].right;

  drawarrow table[3].row[6].lower{(-3, -1)}...{(-3, -1)}label[1].upper + (3objspacing, 0);
  drawarrow label[1].lower + (3objspacing, 0){(4, -1)}...{(-4, -1)}table[4].row[2].right;

  drawcmds;
  drawlabels;

  % Arrows from each SQL command to the resulting row as well as to the
  % corresponding row of the log table. Besides the fact that adjustpens must
  % have been called, we should not do it before filling the rectangles
  % (because that would overwrite parts of the arrows).
  pickup arrowpen;
  drawarrow cmd[0].right{(1, 1)}...{right}table[1].row[0].left;

  drawarrow cmd[1].right{right}...{right}table[2].row[3].left;

  drawarrow cmd[2].right{right}...{right}table[3].row[6].left;

  % The direction of time. XXX What's the appropriate length of the arrow?
  drawarrow (xpart table[5].ll, ypart table[8].lr)--(xpart table[5].ll, ypart table[8].lr) + (5objspacing, 0);

  drawboundingboxwhite;
endfig;
end
