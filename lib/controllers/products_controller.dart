import 'package:get/get.dart';

import '../domain/product.dart';

class ProductController extends GetxController {
  RxList<Product> products = [
    Product(
        0,
        "https://cdn.discordapp.com/attachments/833897513349021706/955338658792243220/unsplash_Sm7ebvMgi-E_1.png",
        "Product name",
        "Store name",
        "200",
        "Dog"),
    Product(
        1,
        "https://cdn.discordapp.com/attachments/833897513349021706/955338900002455642/unsplash_2hpiy9XuXC4.png",
        "Product name",
        "Store name",
        "200",
        "Dog"),
    Product(
        2,
        "https://cdn.discordapp.com/attachments/833897513349021706/955339290785742858/unsplash_FiQNJA-CND4.png",
        "Product name",
        "Store name",
        "200",
        "Cat"),
    Product(
        3,
        "https://cdn.discordapp.com/attachments/833897513349021706/955338658792243220/unsplash_Sm7ebvMgi-E_1.png",
        "Product name",
        "Store name",
        "200",
        "Fish"),
    Product(
        4,
        "https://cdn.discordapp.com/attachments/833897513349021706/955338658792243220/unsplash_Sm7ebvMgi-E_1.png",
        "Product name",
        "Store name",
        "200",
        "Bird")
  ].obs;
  List<Product> filteredList = [Product(0, "", "", "", "", "")].obs;
  final filter = "".obs;

  String get getFilter {
    return filter.value;
  }

  void changeFilter(String newfilter) {
    filter.value = newfilter;
    print(filter.value);
  }

  void filterCategory(String newFilter) {
    List<Product> a = products.where((p0) => p0.type == newFilter).toList();
    filteredList = a;
    print(filteredList[0].type);
  }
}
