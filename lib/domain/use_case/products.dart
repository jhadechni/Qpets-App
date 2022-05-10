import 'package:get/get.dart';
import 'package:qpets_app/domain/entities/product.dart';
import 'package:qpets_app/domain/repositories/product_repository.dart';

//use cases
class ProductsUseCase {

  ProductRepository repository = Get.find();
  Future<List<Product>> getAllPlaces() async => await repository.getAllProducts();
  Future<void> addProduct(product) async => await repository.addProduct(product);
  Future<void> deleteAll() async => await repository.deleteAll();

}