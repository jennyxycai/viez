import 'package:viez/data/repository/products_repository.dart';
import 'package:viez/entity/meal_entity.dart';

class SearchProductByBarcodeUseCase {
  final ProductsRepository _productsRepository;

  SearchProductByBarcodeUseCase(this._productsRepository);

  Future<MealEntity> searchProductByBarcode(String barcode) async {
    return await _productsRepository.getOFFProductByBarcode(barcode);
  }
}
