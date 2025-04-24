import 'package:food_delivery_app/Model/shaorma_model.dart';

List<ShaormaModel> getShaorma() {
  List<ShaormaModel> shaorma = [];
  ShaormaModel shaormaModel = new ShaormaModel();

  shaormaModel.name = "Shaorma";
  shaormaModel.image = "assets/images/singleshaorma.png";
  shaormaModel.price = "\$55";
  shaorma.add(shaormaModel);
  shaormaModel = new ShaormaModel();

  shaormaModel.name = "Shaormas";
  shaormaModel.image = "assets/images/shaorma.png";
  shaormaModel.price = "\$60";
  shaorma.add(shaormaModel);
  shaormaModel = new ShaormaModel();

  shaormaModel.name = "Sos-Shaorma";
  shaormaModel.image = "assets/images/sos_shaorma.png";
  shaormaModel.price = "\$70";
  shaorma.add(shaormaModel);
  shaormaModel = new ShaormaModel();

  shaormaModel.name = "to-shaorma";
  shaormaModel.image = "assets/images/tomato_shaorma.png";
  shaormaModel.price = "\$40";
  shaorma.add(shaormaModel);
  shaormaModel = new ShaormaModel();

  shaormaModel.name = "maton-shaorma";
  shaormaModel.image = "assets/images/maton_shaorma.png";
  shaormaModel.price = "\$100";
  shaorma.add(shaormaModel);
  shaormaModel = new ShaormaModel();

  return shaorma;
}
