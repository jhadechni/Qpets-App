import 'package:get/get.dart';
import 'package:qpets_app/domain/entities/product.dart';
import 'package:qpets_app/domain/repositories/product_repository.dart';

//use cases
class ProductsUseCase {
  ProductRepository repository = Get.find();
  Future<bool> getProductsRemote() async =>
      await repository.getProductsRemote();
  Future<List<Product>> getAllProducts() async =>
      await repository.getAllProducts();
  Future<void> addProduct(product) async =>
      await repository.addProduct(product);
  Future<void> deleteAll() async => await repository.deleteAll();

  Future<List<Product>> getProductsUser(id) async =>
      await repository.getProductsUser(id);

  Future<bool> deleteProductsUser(id) async =>
      await repository.deleteProduct(id);
}
