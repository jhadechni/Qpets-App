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

  Future<bool> getProductsRemote() async {
    try {
      List<Product> products =
          await remoteDataSource.getItems(); //change to list of places
      await localDataSource.addAllProducts(products);
      print("Local");
      print(products);
    } catch (e) {
      print("Error $e");
      return false;
    }
    //insert items in the database foreach
    return true;
  }

  Future<List<Product>> getAllProducts() async =>
      await localDataSource.getAllProducts();

  Future<void> deleteAll() async => await localDataSource.deleteAll();

  Future<void> addProduct(Product product) async {
    try {
      await localDataSource.addProduct(product);
      await remoteDataSource.addProductRemote(product);
    } catch (e) {
      print("Error $e");
    }
  }

  Future<List<Product>> getProductsUser(id) async =>
      await remoteDataSource.getProductsUser(id);

  Future<bool> deleteProduct(String productid) async =>
      await remoteDataSource.deleteProductsUser(productid);
}
