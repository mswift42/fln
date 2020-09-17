import 'dart:convert';

import 'package:fln/product.dart' show Product;
import 'package:fln/store.dart' show Store;
import 'package:http/http.dart' as http;

class CexSearch {
  final String query;
  final Store store;

  CexSearch({this.query, this.store});

  String url(String query, String storeid) {
    return 'https://wss2.cex.uk.webuy.io/v3/boxes?q=$query&storeIds=[$store.location]&firstRecord=1&count=50&sortBy=sellprice&sortOrder=desc';
  }

  String prodUrl(String id) {
    return 'https://uk.webuy.com/product-detail?id=$id';
  }

  Future<List<Product>> fetchProduct() async {
    final cu = url(query, store.id);
    final response = await http.get(cu);

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body) as List;
      if (decoded != null) {
        return decoded.map((i) => Product.fromJson(i)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to load product");
    }
  }
}
