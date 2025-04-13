import 'package:food_delivery_app/Model/pizza_model.dart';

List<PizzaModel> getPizza() {
  List<PizzaModel> pizza = [];
  PizzaModel pizzaModel = new PizzaModel();

  pizzaModel.name = "Chince Pizza";
  pizzaModel.image = "assets/images/chincepizza.png";
  pizzaModel.price = "\$50";
  pizza.add(pizzaModel);
  pizzaModel = new PizzaModel();

  pizzaModel.name = "Margaripizza";
  pizzaModel.image = "assets/images/margaripizza.png";
  pizzaModel.price = "\$70";
  pizza.add(pizzaModel);
  pizzaModel = new PizzaModel();
  pizzaModel.name = "Chince Pizza";
  pizzaModel.image = "assets/images/chincepizza.png";
  pizzaModel.price = "\$50";
  pizza.add(pizzaModel);
  pizzaModel = new PizzaModel();

  pizzaModel.name = "Margaripizza";
  pizzaModel.image = "assets/images/margaripizza.png";
  pizzaModel.price = "\$70";
  pizza.add(pizzaModel);
  pizzaModel = new PizzaModel();

  pizzaModel.name = "Chince Pizza";
  pizzaModel.image = "assets/images/chincepizza.png";
  pizzaModel.price = "\$50";
  pizza.add(pizzaModel);
  pizzaModel = new PizzaModel();

  pizzaModel.name = "Margaripizza";
  pizzaModel.image = "assets/images/margaripizza.png";
  pizzaModel.price = "\$70";
  pizza.add(pizzaModel);
  pizzaModel = new PizzaModel();

  return pizza;
}
