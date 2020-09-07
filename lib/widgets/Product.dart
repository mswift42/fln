import 'package:fln/product.dart';
import 'package:flutter/material.dart';

class ProductsWidget extends StatelessWidget {
  final List<Product> products;

  ProductsWidget(this.products);

  @override
  Widget build(BuildContext context) {
    if (products.length == 0) {
      return Container(
        child: Center(
          child: Text("No results found :("),
        ),
      );
    }
    return GridView.extent(
        maxCrossAxisExtent: 320.0,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 1.0,
        children: products.map((i) => ProductWidget(i)).toList());
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    final _ts = Theme.of(context).textTheme.body1;
    final _prodtextline = product.title.split(',');
    final _des = _prodtextline[0];
    final _condition = (_prodtextline.length == 2) ? _prodtextline[1] : '?';
    return GestureDetector(
      onTap: () => _launchUrl(product.url),
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
                constraints: BoxConstraints(
                  maxHeight: 200.0,
                ),
                child: ProductImage(product.thumbnail)),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    children: <Widget>[
                      Text(
                        _des,
                        style: _ts,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              _ProductBottomLine(
                product: product,
                condition: _condition,
                textstyle: _ts,
              ),
            ],
          ),
        ],
      )),
    );
  }
}
