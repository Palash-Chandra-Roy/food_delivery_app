import 'package:food_delivery_app/Model/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = [];
  CategoryModel categoryModel = new CategoryModel();

  categoryModel.name = "Pizza";
  categoryModel.image = "assets/images/pizza.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.name = "Burger";
  categoryModel.image = "assets/images/buger.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.name = "Chiken";
  categoryModel.image = "assets/images/chiken.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  categoryModel.name = "Shaorma";
  categoryModel.image = "assets/images/shaorma.png";
  category.add(categoryModel);
  categoryModel = new CategoryModel();

  return category;
}
