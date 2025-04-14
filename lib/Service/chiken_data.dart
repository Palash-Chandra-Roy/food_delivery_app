import 'package:food_delivery_app/Model/chiken_model.dart';

List<ChikenModel> getChiken() {
  List<ChikenModel> chiken = [];
  ChikenModel chikenModel = new ChikenModel();

  chikenModel.name = "Chiken";
  chikenModel.image = "assets/images/chiken.png";
  chikenModel.price = "\$50";
  chiken.add(chikenModel);
  chikenModel = new ChikenModel();

  chikenModel.name = "Whole Chicken";
  chikenModel.image = "assets/images/whole-chicken.png";
  chikenModel.price = "\$60";
  chiken.add(chikenModel);
  chikenModel = new ChikenModel();

  chikenModel.name = "Friechiken";
  chikenModel.image = "assets/images/friechiken.png";
  chikenModel.price = "\$55";
  chiken.add(chikenModel);
  chikenModel = new ChikenModel();

  chikenModel.name = "Runchikan";
  chikenModel.image = "assets/images/runchikan.png";
  chikenModel.price = "\$70";
  chiken.add(chikenModel);
  chikenModel = new ChikenModel();

  chikenModel.name = "Fullchikan";
  chikenModel.image = "assets/images/fullchikan.png";
  chikenModel.price = "\$200";
  chiken.add(chikenModel);
  chikenModel = new ChikenModel();

  return chiken;
}
