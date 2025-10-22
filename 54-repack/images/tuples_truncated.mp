input TEX;
input "metapostgres/common";
input "metapostgres/table";

hppp := 0.2;
vppp := 0.2;
outputformatoptions := "format=rgb";

prologues := 3;

tablebgcolor := hexrgbcolor("99")("77")("00");
% Label actually means tuple here.
labelbgcolor := hexrgbcolor("EE")("CC")("66");

color	color_save, color_dead;

color_dead := hexrgbcolor("00")("00")("00");

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
  label[0].notext := true;

  createlabel("xxxxxxxxxxxx");
  label[1].ul = label[0].ll - (0, objspacing);
  label[1].notext := true;

  createlabel("xxxxxxxxxxxx");
  label[2].ul = label[1].ll - (0, objspacing);
  label[2].notext := true;

  % Page 1
  createlabel("xxxxxxxxxxxx");
  label[3].ul = label[2].ll - (0, objspacing);
  label[3].notext := true;

  createlabel("xxxxxxxxxxxx");
  label[4].ul = label[3].ll - (0, objspacing);
  label[4].notext := true;

  createlabel("xxxxxxxxxxxx");
  label[5].ul = label[4].ll - (0, objspacing);
  label[5].notext := true;

  finalizelabels;

  rightborder := 3objspacing;

  initboundingbox(label[5].ll - (objspacing, objspacing))
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

  % Draw the tuples.
  drawlabel(0);

  drawlabel(1);
  drawlabel(2);
  drawlabel(3);
  drawlabel(4);

  % Make sure the picture does contain the bounding box. Without that, the
  % picture contents might be scaled too much, as if there was no bounding
  % box.
  drawboundingboxwhite;
endfig;
end
