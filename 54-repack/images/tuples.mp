input TEX;
input "metapostgres/common";
input "metapostgres/repack";

hppp := 0.2;
vppp := 0.2;
outputformatoptions := "format=rgb";

prologues := 3;

tablebgcolor := hexrgbcolor("F2")("ED")("87");
% Label actually means tuple here.
labelbgcolor := hexrgbcolor("FF")("E3")("B2");

beginfig(1);
  path	page[];
  % The space between the tuple and the right border of the page.
  numeric	rightborder;

  % Page 0
  %
  % The text is Just a placeholder, to make the row wide enough - replace with
  % text (e.g. "DEAD TUPLE") if needed.
  createlabel("xxxxxxxxxxxx");
  label[0].ll = (0, 0);

  createlabel("xxxxxxxxxxxx");
  label[1].ul = label[0].ll - (0, objspacing);

  createlabel("xxxxxxxxxxxx");
  label[2].ul = label[1].ll - (0, objspacing);

  % Page 1
  createlabel("xxxxxxxxxxxx");
  label[3].ul = label[2].ll - (0, objspacing);

  createlabel("xxxxxxxxxxxx");
  label[4].ul = label[3].ll - (0, objspacing);

  createlabel("xxxxxxxxxxxx");
  label[5].ul = label[4].ll - (0, objspacing);

  % Page 2
  createlabel("xxxxxxxxxxxx");
  label[6].ul = label[5].ll - (0, objspacing);

  createlabel("xxxxxxxxxxxx");
  label[7].ul = label[6].ll - (0, objspacing);

  % Hide this completely - just a placeholder.
  createlabel("xxxxxxxxxxxx");
  label[8].ul = label[7].ll - (0, objspacing);

  % Page 3
  createlabel("xxxxxxxxxxxx");
  label[9].ul = label[8].ll - (0, objspacing);

  createlabel("xxxxxxxxxxxx");
  label[10].ul = label[9].ll - (0, objspacing);

  % Hide this completely - just a placeholder.
  createlabel("xxxxxxxxxxxx");
  label[11].ul = label[10].ll - (0, objspacing);

  finalizelabels;

  rightborder := 3objspacing;

  initboundingbox(label[11].ll - (objspacing, objspacing))
    (label[0].ur + (objspacing + rightborder, objspacing));
  computescalefactor(metapg.bbox);

  adjustpens;
  fixpicturewidth;

  % Draw the page boundaries.
  pickup tablepen;

  page[0] := label[0].ul + (-.5objspacing, .5objspacing)--
    label[2].ll + (-.5objspacing, -.5objspacing) --
    label[2].lr + (.5objspacing + rightborder, -.5objspacing) --
    label[0].ur + (.5objspacing + rightborder, .5objspacing) -- cycle;
  draw page[0];
  fill page[0] withcolor tablebgcolor;

  page[1] := label[3].ul + (-.5objspacing, .5objspacing)--
    label[5].ll + (-.5objspacing, -.5objspacing) --
    label[5].lr + (.5objspacing + rightborder, -.5objspacing) --
    label[3].ur + (.5objspacing + rightborder, .5objspacing) -- cycle;
  draw page[1];
  fill page[1] withcolor tablebgcolor;

  page[2] := label[6].ul + (-.5objspacing, .5objspacing)--
    label[8].ll + (-.5objspacing, -.5objspacing) --
    label[8].lr + (.5objspacing + rightborder, -.5objspacing) --
    label[6].ur + (.5objspacing + rightborder, .5objspacing) -- cycle;
  draw page[2];
  fill page[2] withcolor tablebgcolor;

  page[3] := label[9].ul + (-.5objspacing, .5objspacing)--
    label[11].ll + (-.5objspacing, -.5objspacing) --
    label[11].lr + (.5objspacing + rightborder, -.5objspacing) --
    label[9].ur + (.5objspacing + rightborder, .5objspacing) -- cycle;
  draw page[3];
  fill page[3] withcolor tablebgcolor;

  % Draw the tuples.
  drawlabel(0);
  drawlabel(1);
  drawlabel(2);
  drawlabel(3);
  drawlabel(4);
  drawlabel(5);
  drawlabel(6);
  drawlabel(7);
  drawlabel(8);
  drawlabel(9);
  drawlabel(10);
  % 11 is not there.

  % Make sure the picture does contain the bounding box. Without that, the
  % picture contents might be scaled too much, as if there was no bounding
  % box.
  drawboundingboxwhite;
endfig;
end
