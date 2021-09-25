import 'dart:async';
import 'dart:convert';

import 'package:fln/cexsearch.dart';
import 'package:fln/last_search.dart';
import 'package:fln/product.dart';
import 'package:fln/store.dart';
import 'package:fln/widgets/Product.dart';
import 'package:fln/widgets/lastsearchlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScaffold extends StatelessWidget {
  final String? title;

  const HomeScaffold({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: const Center(
        child: SearchWidget(),
      ),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({Key? key}) : super(key: key);

  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final LastSearchService searchServie = LastSearchService();
  Store? activeStore = _stores[0];
  String searchquery = "";
  Set<String> _lastSearches = {};
  static final _stores = [
    const Store("Rose St.", "54"),
    const Store("Cam. Toll", "3017"),
    const Store("Leith", "3115")
  ];
  final controller = TextEditingController();

  void _searchProduct(String inp) async {
    if (inp != '') {
      _lastSearches.add(inp);
      searchServie.writeSearches(_lastSearches.toList());
      var cs = CexSearch(query: searchquery, store: activeStore);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
                title: Text(
              "Showing $searchquery at ${activeStore!.location}.",
              textScaleFactor: 0.7,
            )),
            body: _showResultsBody(cs.fetchProduct()),
          ),
        ),
      );
    }
  }

  void _setSearchQueryText() {
    searchquery = controller.text;
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_setSearchQueryText);
    searchServie.readSearches().then((List? value) {
      setState(() {
        _lastSearches = Set.from(value!);
      });
    });
  }

  void handleActiveStoreChanged(Store? store) async {
    setState(() {
      activeStore = store;
    });
    _searchProduct(searchquery);
  }

  void _handlePillTap(String inp) {
    setState(() {
      searchquery = inp;
      controller.text = inp;
      _searchProduct(searchquery);
    });
  }

  @override
  void dispose() {
    controller.removeListener(_setSearchQueryText);
    controller.dispose();
    super.dispose();
  }

  Uri prodUrl(String query, String storeid) {
    return Uri.https('cxchecker.appspot.com', '/querycx',
        {'query': query, 'location': storeid});
  }

  Future<List<Product>> fetchProduct(String query, String storeid) async {
    final url = prodUrl(query, storeid);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var decoded = json.decode(response.body) as List?;
      if (decoded != null) {
        return decoded.map((i) => Product.fromJson(i)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to load product");
    }
  }

  void _handleDelete(String value) {
    setState(() {
      _lastSearches.remove(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var mw = 1000.0;
    return Container(
      width: mw,
      child: Column(
        children: <Widget>[
          Container(
            child: TextField(
              controller: controller,
              onSubmitted: _searchProduct,
            ),
            padding: EdgeInsets.symmetric(vertical: 6.00, horizontal: 8.00),
          ),
          Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _stores
                    .map((i) =>
                        _radioWidget(i, activeStore, handleActiveStoreChanged))
                    .toList(),
              ),
            ],
          ),
          LastSearchGrid(_handleDelete, _handlePillTap, _lastSearches.toList())
        ],
      ),
    );
  }
}

Widget _radioWidget(
    Store value, Store? groupvalue, ValueChanged<Store?> handler) {
  return Row(
    children: <Widget>[
      Text(value.location),
      Radio<Store>(
        value: value,
        groupValue: groupvalue,
        onChanged: handler,
      ),
    ],
  );
}

FutureBuilder<List<Product>> _showResultsBody(Future<List<Product>> handler) {
  return FutureBuilder(
    future: handler,
    builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return Container(child: Center(child: Text("Please try again.")));
        case ConnectionState.active:
        case ConnectionState.waiting:
          return Container(child: Center(child: CircularProgressIndicator()));
        case ConnectionState.done:
          if (snapshot.hasError) {
            return Text("Something went wrong: ${snapshot.error}");
          }
          return ProductsWidget(snapshot.data);
      }
    },
  );
}
