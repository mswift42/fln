import 'package:fln/store.dart' show Store;

class CexSearch {
  final String query;
  final Store store;

  CexSearch({this.query, this.store});

  String prodUrl(String query, String storeid) {
    return 'https://wss2.cex.uk.webuy.io/v3/boxes?q=$query&storeIds=[$store.location]&firstRecord=1&count=50&sortBy=sellprice&sortOrder=desc';
  }
}
