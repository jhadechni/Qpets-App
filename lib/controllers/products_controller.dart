import 'package:get/get.dart';
import 'package:qpets_app/domain/entities/product.dart';
import 'package:qpets_app/domain/use_case/products.dart';

class ProductController extends GetxController {
  final products = <Product>[].obs;
  bool sucess = false;
  ProductsUseCase productsUseCase = Get.find();

  ProductController() {
    getProductFromRepository();
    filterCategory("");
    print(products);
  }
  List get getProducts => products;
  bool get getStatus => sucess;
  
  RxList<Product> filteredList = <Product>[].obs;
  final filter = "".obs;

  Future<void> getProductFromRepository() async {
    sucess = await productsUseCase.getProductsRemote();
    await getAllProducts();
  }

  Future<void> getAllProducts() async {
    var list = await productsUseCase.getAllProducts();
    products.value = list;
    filteredList.value = list;
  }

  addProduct(Product product) async {
    products.add(product);
    await productsUseCase.addProduct(product);
  }

  String get getFilter {
    return filter.value;
  }

  void changeFilter(String newfilter) {
    filter.value = newfilter;
  }

  void filterCategory(String newFilter) {
    List<Product> copyOfProducts = List<Product>.from(products);

    if (newFilter.isEmpty || newFilter == "All") {
      filteredList.value = copyOfProducts;
    } else {
      filteredList.value =
          copyOfProducts.where((p0) => p0.type == newFilter).toList();
    }
    filteredList.refresh();
  }

  void runFilter(String enteredKeyword) {
    List<Product> copyOfProducts = List<Product>.from(products);
    if (enteredKeyword.isEmpty) {
      filteredList.value = copyOfProducts;
    } else {
      filteredList.value = copyOfProducts
          .where((product) =>
              product.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    filteredList.refresh();
  }
}
