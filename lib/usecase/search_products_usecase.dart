import 'package:viez/data/repository/products_repository.dart';
import 'package:viez/entity/meal_entity.dart';

class SearchProductsUseCase {
  final ProductsRepository _productsRepository;

  SearchProductsUseCase(this._productsRepository);

  Future<List<MealEntity>> searchOFFProductsByString(
      String searchString) async {
    final products =
        await _productsRepository.getOFFProductsByString(searchString);
    return products;
  }

  /*
  Future<List<MealEntity>> searchFDCFoodByString(String searchString) async {
    final foods =
        await _productsRepository.getSupabaseFDCFoodsByString(searchString);
    return foods;
  }

   */
}
