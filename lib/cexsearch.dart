import 'dart:convert';

import 'package:fln/product.dart' show Product;
import 'package:fln/store.dart' show Store;
import 'package:http/http.dart' as http;

class CexSearch {
  final String query;
  final Store store;

  CexSearch({this.query, this.store});

  Uri url(String query, String storeid) {
    Uri uri = Uri.https('wss2.cex.uk.webuy.io', '/v3/boxes', {
      'q': query,
      'storeIds': '[${store.id}]',
      'firstRecord': '1',
      'count': '50',
      'sortBy': 'sellprice',
      'sortOrder': 'desc'
    });
    return uri;
  }

  Uri prodUrl(String id) {
    return Uri.https('uk.webuy.com', '/product-detail', {'id': id});
  }

  Future<List<Product>> fetchProduct() async {
    final cu = url(query, store.id);
    final response = await http.get(cu);

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      var dt = decoded["response"]["data"];
      if (dt != null) {
        var jsonlist = dt["boxes"] as List;
        return jsonlist.map((i) => Product.fromJson(i)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to load product");
    }
  }
}
