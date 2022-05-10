import 'package:qpets_app/data/datasources/remote/product_remote_datasource.dart';
import '../../data/datasources/local/products_local_datasource_sqflite.dart';
import '../entities/product.dart';

class ProductRepository {
  late ProductsClient remoteDataSource;
  late ProductLocalDataSource localDataSource;

  ProductRepository() {
    remoteDataSource = ProductsClient();
    localDataSource = ProductLocalDataSource();
  }


  Future<List<Product>> getAllProducts() async =>
      await localDataSource.getAllProducts();

  Future<void> deleteAll() async => await localDataSource.deleteAll();

  Future<void> addProduct(Product product) async => await localDataSource.addProduct(product);


}
