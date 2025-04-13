import 'package:food_delivery_app/Model/burger_model.dart';

List<BurgerModel> getBurger() {
  List<BurgerModel> burger = [];
  BurgerModel burgerModel = new BurgerModel();

  burgerModel.name = "Bangla Burger";
  burgerModel.image = "assets/images/bangla.png";
  burgerModel.price = "\$50";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "India Burger";
  burgerModel.image = "assets/images/India.png";
  burgerModel.price = "\$60";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Bhutan Burger";
  burgerModel.image = "assets/images/bhutan.png";
  burgerModel.price = "\$40";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Chinces Burger";
  burgerModel.image = "assets/images/chinces.png";
  burgerModel.price = "\$80";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "USA Burger";
  burgerModel.image = "assets/images/usa.png";
  burgerModel.price = "\$100";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Margari Burger";
  burgerModel.image = "assets/images/buger.png";
  burgerModel.price = "\$70";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  return burger;
}
