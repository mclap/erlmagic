-module(example).
-compile(export_all).

init() ->	
    Host = imagelib:start(),
    Image = imagelib:read(Host, "test.jpg"),
    io:format("Image = ~p~n", [Image]),
    imagelib:scale(Host, Image, "20%"),
    {Host, Image}.

adaptiveTheshold(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:adaptiveThreshold(Host, Image, 5, 5, 5),
    imagelib:label(Host, Image, "adaptiveTheshold"),
    Ex.

annotate(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:annotate(Host, Image,"Erl Magick","+0+10"),
    imagelib:label(Host, Image, "annotate"),
    Ex.

blur(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:blur(Host, Image,0.0, 1.0),
    imagelib:label(Host, Image, "blur"),
    Ex.

border(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:border(Host, Image,"6x6"),
    imagelib:label(Host, Image, "border"),
    Ex.

charcoal(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:charcoal(Host, Image,0.0,1.0),
    imagelib:label(Host, Image, "charcoal"),
    Ex.

chop(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:chop(Host, Image,"80x80+25+50"),
    imagelib:label(Host, Image, "chop"),
    Ex.

composite(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    Smiley = imagelib:read(Host, "smiley.jpg"),
    imagelib:composite(Host, Image,Smiley,"+35+65","OverCompositeOp"),
    imagelib:label(Host, Image, "composite"),
    Ex.

contrast(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:contrast(Host, Image, 10),
    imagelib:label(Host, Image, "contrast"),
    Ex.

crop(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:crop(Host, Image,"80x80+25+50"),
    imagelib:label(Host, Image, "crop"),
    Ex.


despeckle(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:despeckle(Host, Image),
    imagelib:label(Host, Image, "despeckle"),
    Ex.


edge(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:edge(Host, Image, 0.0),
    imagelib:label(Host, Image, "edge"),
    Ex.

emboss(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:emboss(Host, Image,0.0,1.0),
    imagelib:label(Host, Image, "emboss"),
    Ex.

enhance(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:enhance(Host, Image),
    imagelib:label(Host, Image, "enhance"),
    Ex.

equalize(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:equalize(Host, Image),
    imagelib:label(Host, Image, "equalize"),
    Ex.

erase(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:erase(Host, Image),
    imagelib:label(Host, Image, "erase"),
    Ex.

flip(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:flip(Host, Image),
    imagelib:label(Host, Image, "flip"),
    Ex.


flop(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:flop(Host, Image),
    imagelib:label(Host, Image, "flop"),
    Ex.


gamma(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:gamma(Host, Image,1.6),
    imagelib:label(Host, Image, "gamma"),
    Ex.

gaussianBlur(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:gaussianBlur(Host, Image,0.0,1.5),
    imagelib:label(Host, Image, "gaussianBlur"),
    Ex.

implode(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:implode(Host, Image,-1.0),
    imagelib:label(Host, Image, "implode"),
    Ex.

level(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:level(Host, Image,20.0,20.0,1.0),
    imagelib:label(Host, Image, "level"),
    Ex.


medianFilter(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:medianFilter(Host, Image,0.0),
    imagelib:label(Host, Image, "medianFilter"),
    Ex.


modulate(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:modulate(Host, Image,110.0,110.0, 110.0),
    imagelib:label(Host, Image, "modulate"),
    Ex.

negate(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:negate(Host, Image, 0),
    imagelib:label(Host, Image, "negate"),
    Ex.

normalize(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:normalize(Host, Image),
    imagelib:label(Host, Image, "normalize"),
    Ex.

oilPaint(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:oilPaint(Host, Image, 3.0),
    imagelib:label(Host, Image, "oilPaint"),
    Ex.


quantize(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:quantize(Host, Image, 0),
    imagelib:label(Host, Image, "quantize"),
    Ex.

raise(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:raise(Host, Image, "10x10",0),
    imagelib:label(Host, Image, "raise"),
    Ex.

reduceNoise(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:reduceNoise(Host, Image),
    imagelib:label(Host, Image, "reduceNoise"),
    Ex.

roll(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:roll(Host, Image, 10, 10),
    imagelib:label(Host, Image, "roll"),
    Ex.

rotate(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:rotate(Host, Image,45.0),
    imagelib:label(Host, Image, "rotate"),
    Ex.

sample(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:sample(Host, Image, "60%"),
    imagelib:label(Host, Image, "sample"),
    Ex.

scale(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:scale(Host, Image, "60%"),
    imagelib:label(Host, Image, "scale"),
    Ex.

segment(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:segment(Host, Image, 1.0, 1.5),
    imagelib:label(Host, Image, "segment"),
    Ex.

shade(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:shade(Host, Image, 30.0, 30.0, 1),
    imagelib:label(Host, Image, "shade"),
    Ex.

sharpen(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:sharpen(Host, Image, 0.0, 1.0),
    imagelib:label(Host, Image, "sharpen"),
    Ex.

shave(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:shave(Host, Image,"10x10"),
    imagelib:label(Host, Image, "shave"),
    Ex.

shear(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:shear(Host, Image, -20.0, 20.0),
    imagelib:label(Host, Image, "shear"),
    Ex.

solarize(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:solarize(Host, Image, 50.0),
    imagelib:label(Host, Image, "solarize"),
    Ex.

spread(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:spread(Host, Image, 3.0),
    imagelib:label(Host, Image, "spread"),
    Ex.


swirl(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:swirl(Host, Image, 90.0),
    imagelib:label(Host, Image, "swirl"),
    Ex.


unsharpmask(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:unsharpmask(Host, Image, 3.0, 1.0, 5.0, 1.0),
    imagelib:label(Host, Image, "unsharpmask"),
    Ex.

wave(Host, Image) ->
    Ex = imagelib:clone(Host, Image),
    imagelib:wave(Host, Image, 25.0, 150.0),
    imagelib:label(Host, Image, "wave"),
    Ex.


start() ->
    {Host, Image} = init(),
    Funs = [adaptiveTheshold, annotate, blur, border, charcoal, chop, composite, contrast, crop, despeckle, edge, emboss, enhance, equalize, erase, flip, flop, gamma, gaussianBlur, implode, level, medianFilter, modulate, negate, normalize, oilPaint, quantize, raise, reduceNoise, roll, rotate, sample, scale, segment, shade, sharpen, shave, shear, solarize, spread, swirl, unsharpmask, wave],
    Montage = imagelib:montageImages(Host, [X(Host, Image) || X <- Funs], "example.jpg"),
    imagelib:display(Host, Montage).
