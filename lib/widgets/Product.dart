import 'package:fln/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Container(
      color: Colors.black87,
      child: GridView.extent(
          maxCrossAxisExtent: 320.0,
          mainAxisSpacing: 2.0,
          crossAxisSpacing: 1.0,
          children: products.map((i) => ProductWidget(i)).toList()),
    );
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget(this.product);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    final _ts = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w300,
      fontSize: 14.0,
    );

    return GestureDetector(
      onTap: () => _launchUrl(product.url),
      child: Card(
          child: Stack(
        children: <Widget>[
          Container(
              constraints: BoxConstraints(
                maxHeight: _height,
              ),
              child: ProductImage(product.thumbnail)),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            top: _height / 3.0,
            child: Container(
              color: Colors.black87,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 2.0, top: 4.0, bottom: 4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
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
                  ),
                  _ProductBottomLine(
                    product: product,
                    textstyle: _ts,
                  ),
                ],
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
    Key key,
    @required this.product,
    @required this.textstyle,
  }) : super(key: key);

  final Product product;
  final TextStyle textstyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            product.condition,
            style: textstyle,
          ),
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
        fit: BoxFit.contain,
      ),
    );
  }
}

_launchUrl(String url) async {
  await launch(url);
}
