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
}
