import 'package:get/get.dart';
import 'package:qpets_app/domain/use_case/products.dart';
import '../domain/product.dart';

class ProductController extends GetxController {
  late List products = [].obs;
  ProductsUseCase productsUseCase = Get.find();

  ProductController() {
    filterCategory("");
    getAllPlaces();
  }
  List get getProducts => products;

  RxList<Product> filteredList = <Product>[].obs;
  final filter = "".obs;

  Future<void> getAllPlaces() async {
    var list = await productsUseCase.getAllPlaces();
    products = list;
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
}
