import 'package:fln/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductsWidget extends StatelessWidget {
  final List<Product>? products;

  ProductsWidget(this.products);

  @override
  Widget build(BuildContext context) {
    if (products!.isEmpty) {
      return Container(
        child: Center(
          child: Text("No results found :("),
        ),
      );
    }
    return Container(
      color: Colors.white,
      child: GridView.extent(
        shrinkWrap: true,
          maxCrossAxisExtent: 300.0,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: products!.map((i) => ProductWidget(i)).toList()),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    final _ts = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w300,
      fontSize: 14.0,
    );

    return GestureDetector(
      onTap: () => _launchUrl(product.url),
      child: Card(
        color: Colors.black87,
          child: Stack(
        children: <Widget>[
          ProductImage(product.thumbnail),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 80.0,
                minWidth: 0.0,
                maxHeight: 300.0,
              ),
              child: FractionallySizedBox(
                heightFactor: 0.3,
                child: Container(
                  color: Colors.black87,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 2.0, top: 4.0, bottom: 4.0),
                        child: Wrap(
                          children: <Widget>[
                            Text(
                              product.description,
                              style: _ts,
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      _ProductBottomLine(
                        product: product,
                        textstyle: _ts,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class _ProductBottomLine extends StatelessWidget {
  const _ProductBottomLine({
    Key? key,
    required this.product,
    required this.textstyle,
  }) : super(key: key);

  final Product product;
  final TextStyle textstyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          product.condition,
          style: textstyle,
          textAlign: TextAlign.left,
        ),
        Text(
          (product.price == null)
              ? "0"
              : product.price.toStringAsFixed(
                  product.price.truncateToDouble() == product.price ? 0 : 2),
          style: textstyle,
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imageurl;

  ProductImage(this.imageurl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Image.network(
        imageurl,
        fit: BoxFit.fitWidth,
        cacheHeight: 236,
        cacheWidth: 250,
      ),
    );
  }
}

_launchUrl(String url) async {
  await launch(url);
}
