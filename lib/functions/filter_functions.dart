import 'package:food_delivery_app/models/foods_model.dart';

List<Food> sortFoods(List<Food> foods, String sortType) {
  switch (sortType) {
    case 'name_asc':
      foods.sort((a, b) => a.name.compareTo(b.name));
      break;
    case 'name_desc':
      foods.sort((a, b) => b.name.compareTo(a.name));
      break;
    case 'price_asc':
      foods.sort((a, b) => a.price.compareTo(b.price));
      break;
    case 'price_desc':
      foods.sort((a, b) => b.price.compareTo(a.price));
      break;
    default:
      break;
  }
  return foods;
}
