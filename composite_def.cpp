#include <map>

map<string, CompositeOperator> comp_map;

void init_comp(void)
{
  if (comp_map.size() == 0)
    return;

  comp_map["AddCompositeOp"] = AddCompositeOp;
  comp_map["AtopCompositeOp"] = AtopCompositeOp;
  comp_map["BumpmapCompositeOp"] = BumpmapCompositeOp;
  comp_map["ClearCompositeOp"] = ClearCompositeOp;
  comp_map["ColorizeCompositeOp"] = ColorizeCompositeOp;
  comp_map["CopyBlueCompositeOp"] = CopyBlueCompositeOp;
  comp_map["CopyCompositeOp"] = CopyCompositeOp;
  comp_map["CopyGreenCompositeOp"] = CopyGreenCompositeOp;
  comp_map["CopyOpacityCompositeOp"] = CopyOpacityCompositeOp;
  comp_map["CopyRedCompositeOp"] = CopyRedCompositeOp;
  comp_map["DarkenCompositeOp"] = DarkenCompositeOp;
  comp_map["DifferenceCompositeOp"] = DifferenceCompositeOp;
  comp_map["DisplaceCompositeOp"] = DisplaceCompositeOp;
  comp_map["DissolveCompositeOp"] = DissolveCompositeOp;
  comp_map["HueCompositeOp"] = HueCompositeOp;
  comp_map["InCompositeOp"] = InCompositeOp;
  comp_map["LightenCompositeOp"] = LightenCompositeOp;
  comp_map["LuminizeCompositeOp"] = LuminizeCompositeOp;
  comp_map["MinusCompositeOp"] = MinusCompositeOp;
  comp_map["ModulateCompositeOp"] = ModulateCompositeOp;
  comp_map["MultiplyCompositeOp"] = MultiplyCompositeOp;
  comp_map["NoCompositeOp"] = NoCompositeOp;
  comp_map["OutCompositeOp"] = OutCompositeOp;
  comp_map["OverCompositeOp"] = OverCompositeOp;
  comp_map["OverlayCompositeOp"] = OverlayCompositeOp;
  comp_map["PlusCompositeOp"] = PlusCompositeOp;
  comp_map["SaturateCompositeOp"] = SaturateCompositeOp;
  comp_map["ScreenCompositeOp"] = ScreenCompositeOp;
  comp_map["SubtractCompositeOp"] = SubtractCompositeOp;
  comp_map["ThresholdCompositeOp"] = ThresholdCompositeOp;
  comp_map["UndefinedCompositeOp"] = UndefinedCompositeOp;
  comp_map["XorCompositeOp"] = XorCompositeOp;
  comp_map["CopyCyanCompositeOp"] = CopyCyanCompositeOp;
  comp_map["CopyMagentaCompositeOp"] = CopyMagentaCompositeOp;
  comp_map["CopyYellowCompositeOp"] = CopyYellowCompositeOp;
  comp_map["CopyBlackCompositeOp"] = CopyBlackCompositeOp;
}

const CompositeOperator get_composite(string comp) 
{
  init_comp();
  return comp_map[comp];
}
