-module(example).
-compile(export_all).

init() ->	
    Host = imagelib:start(),
    Image = imagelib:read(Host, "test.jpg"),
    io:format("Image = ~p~n", [Image]),
    imagelib:scale(Host, Image, "20%"),
    {Host, Image}.

adaptiveThreshold(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:adaptiveThreshold(Host, Ex, 5, 5, 5),
    imagelib:label(Host, Ex, "adaptiveTheshold"),
    Ex.

annotate(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:annotate(Host, Ex,"Erl Magick","+200+10"),
    imagelib:label(Host, Ex, "annotate"),
    Ex.

blur(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:blur(Host, Ex,0.0, 10.0),
    imagelib:label(Host, Ex, "blur"),
    Ex.

border(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:border(Host, Ex,"6x6"),
    imagelib:label(Host, Ex, "border"),
    Ex.

charcoal(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:charcoal(Host, Ex,0.0,1.0),
    imagelib:label(Host, Ex, "charcoal"),
    Ex.

chop(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:chop(Host, Ex,"60x60+20+30"),
    imagelib:label(Host, Ex, "chop"),
    Ex.

composite(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    Smiley = imagelib:read(Host, "smiley.jpg"),
    imagelib:composite(Host, Ex,Smiley,"+200+130","OverCompositeOp"),
    imagelib:label(Host, Ex, "composite"),
    Ex.

contrast(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:contrast(Host, Ex, 40),
    imagelib:label(Host, Ex, "contrast"),
    Ex.

crop(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:crop(Host, Ex,"165x150+180+80"),
    imagelib:label(Host, Ex, "crop"),
    Ex.


despeckle(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:despeckle(Host, Ex),
    imagelib:label(Host, Ex, "despeckle"),
    Ex.


edge(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:edge(Host, Ex, 0.0),
    imagelib:label(Host, Ex, "edge"),
    Ex.

emboss(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:emboss(Host, Ex,0.0,1.0),
    imagelib:label(Host, Ex, "emboss"),
    Ex.

enhance(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:enhance(Host, Ex),
    imagelib:label(Host, Ex, "enhance"),
    Ex.

equalize(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:equalize(Host, Ex),
    imagelib:label(Host, Ex, "equalize"),
    Ex.

erase(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:erase(Host, Ex),
    imagelib:label(Host, Ex, "erase"),
    Ex.

flip(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:flip(Host, Ex),
    imagelib:label(Host, Ex, "flip"),
    Ex.


flop(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:flop(Host, Ex),
    imagelib:label(Host, Ex, "flop"),
    Ex.


gamma(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:gamma(Host, Ex,1.6),
    imagelib:label(Host, Ex, "gamma"),
    Ex.

gaussianBlur(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:gaussianBlur(Host, Ex,0.0,1.5),
    imagelib:label(Host, Ex, "gaussianBlur"),
    Ex.

implode(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:implode(Host, Ex,-1.0),
    imagelib:label(Host, Ex, "implode"),
    Ex.

level(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:level(Host, Ex,110.0,110.0,1.0),
    imagelib:label(Host, Ex, "level"),
    Ex.


medianFilter(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:medianFilter(Host, Ex,0.0),
    imagelib:label(Host, Ex, "medianFilter"),
    Ex.


modulate(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:modulate(Host, Ex,110.0,110.0, 110.0),
    imagelib:label(Host, Ex, "modulate"),
    Ex.

negate(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:negate(Host, Ex, 0),
    imagelib:label(Host, Ex, "negate"),
    Ex.

normalize(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:normalize(Host, Ex),
    imagelib:label(Host, Ex, "normalize"),
    Ex.

oilPaint(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:oilPaint(Host, Ex, 3.0),
    imagelib:label(Host, Ex, "oilPaint"),
    Ex.


quantize(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:quantize(Host, Ex, 0),
    imagelib:label(Host, Ex, "quantize"),
    Ex.

raise(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:raise(Host, Ex, "10x10",0),
    imagelib:label(Host, Ex, "raise"),
    Ex.

reduceNoise(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:reduceNoise(Host, Ex),
    imagelib:label(Host, Ex, "reduceNoise"),
    Ex.

roll(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:roll(Host, Ex, 10, 10),
    imagelib:label(Host, Ex, "roll"),
    Ex.

rotate(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:rotate(Host, Ex,45.0),
    imagelib:label(Host, Ex, "rotate"),
    Ex.

sample(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:sample(Host, Ex, "60%"),
    imagelib:label(Host, Ex, "sample"),
    Ex.

scale(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:scale(Host, Ex, "60%"),
    imagelib:label(Host, Ex, "scale"),
    Ex.

segment(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:segment(Host, Ex, 1.0, 1.5),
    imagelib:label(Host, Ex, "segment"),
    Ex.

shade(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:shade(Host, Ex, 30.0, 30.0, 1),
    imagelib:label(Host, Ex, "shade"),
    Ex.

sharpen(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:sharpen(Host, Ex, 0.0, 1.0),
    imagelib:label(Host, Ex, "sharpen"),
    Ex.

shave(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:shave(Host, Ex,"10x10"),
    imagelib:label(Host, Ex, "shave"),
    Ex.

shear(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:shear(Host, Ex, -20.0, 20.0),
    imagelib:label(Host, Ex, "shear"),
    Ex.

solarize(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:solarize(Host, Ex, 50.0),
    imagelib:label(Host, Ex, "solarize"),
    Ex.

spread(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:spread(Host, Ex, 3.0),
    imagelib:label(Host, Ex, "spread"),
    Ex.


swirl(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:swirl(Host, Ex, 90.0),
    imagelib:label(Host, Ex, "swirl"),
    Ex.


unsharpmask(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:unsharpmask(Host, Ex, 3.0, 1.0, 5.0, 1.0),
    imagelib:label(Host, Ex, "unsharpmask"),
    Ex.

wave(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:wave(Host, Ex, 25.0, 150.0),
    imagelib:label(Host, Ex, "wave"),
    Ex.


start() ->
    {Host, Image} = init(),
    Funs = [
	    fun adaptiveThreshold/2, fun annotate/2, fun blur/2, fun border/2, fun charcoal/2,
	    fun chop/2, fun composite/2, fun contrast/2,
	    fun crop/2, fun despeckle/2, fun edge/2, fun emboss/2, fun enhance/2, fun equalize/2,
	    fun flip/2, fun flop/2,
	    fun gamma/2, fun gaussianBlur/2, fun implode/2, fun level/2, fun medianFilter/2,
	    fun modulate/2, fun negate/2, fun normalize/2,
	    fun oilPaint/2, fun quantize/2, fun raise/2, fun reduceNoise/2, fun roll/2,
	    fun rotate/2, fun sample/2, fun scale/2, fun segment/2,
	    fun shade/2, fun sharpen/2, fun shave/2, fun shear/2, fun solarize/2, 
	    fun spread/2, fun swirl/2, fun unsharpmask/2, fun wave/2
	   ],
    L = [X(Host, Image) || X <- Funs],
    imagelib:montageImages(Host, L, "9x5", "example.jpg"),
    Montage = imagelib:read(Host, "example.jpg"),
    imagelib:display(Host, Montage).
