import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';
import 'package:qpets_app/domain/entities/product.dart';

class ProductsClient {
  static const baseUrl = "https://qpets.herokuapp.com/products";
  ProductsClient();

  Future<List<Product>> getItems() async {
    var uri = Uri.parse("https://qpets.herokuapp.com/products/getAllProducts")
        .resolveUri(Uri());
    logInfo('Client getItems URI ${uri.toString()}');

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        logInfo("Got code 200");
        var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        List<Product> output = [];
        for (var item in jsonResponse['result']) {
          output.add(Product.fromJson(item));
        }
        logInfo("Client return ok");
        return output;
      } else {
        logError('Client error ${response.statusCode}');
        return Future.error([]);
      }
    } catch (e) {
      logError('Client error Timeout');
      return Future.error('Client error Timeout $e');
    }
  }

  Future<List<Product>> getProductsUser(String id) async {
    var uri =
        Uri.parse("https://qpets.herokuapp.com/products/$id").resolveUri(Uri());
    logInfo('Client getItems URI ${uri.toString()}');
    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 15));
      // print(response.toString());
      if (response.statusCode == 200) {
        logInfo("Got code 200");
        var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        List<Product> output = [];
        for (var item in jsonResponse['products']) {
          output.add(Product.fromJson(item));
        }
        logInfo("Client return ok");
        return output;
      } else {
        logError('Client error ${response.statusCode}');
        return Future.error([]);
      }
    } catch (e) {
      logError('Client error Timeout');
      return Future.error('Client error Timeout $e');
    }
  }

  Future<bool> deleteProductsUser(String id) async {
    var uri =
        Uri.parse("https://qpets.herokuapp.com/products/deleteProduct/$id")
            .resolveUri(Uri());
    logInfo('Client getItems URI ${uri.toString()}');

    try {
      final response =
          await http.post(uri).timeout(const Duration(seconds: 6)); ////////

      if (response.statusCode == 200) {
        logInfo("Got code 200");
        return true;
      } else {
        logError('Client error ${response.statusCode}');
        return false;
      }
    } catch (e) {
      logError('Client error Timeout');
      return false;
    }
  }

  Future<bool> addProductRemote(Product product) async {
    try {
      final res = await http.post(
          Uri.parse("https://qpets.herokuapp.com/products/createProduct"),
          body: jsonEncode(product.toJson()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      print(res.statusCode);
      if (res.statusCode != 200) {
        return Future.error("Pet Post response failed");
      }
      return json.decode(utf8.decode(res.bodyBytes));
    } catch (e) {
      print(e);
      return Future.error("Pet Post failed");
    }
  }
}
