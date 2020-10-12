import 'package:fln/product.dart';
import 'package:flutter/material.dart';
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
    final _ts = Theme.of(context).textTheme.bodyText2;
    return GestureDetector(
      onTap: () => _launchUrl(product.url),
      child: ProductTile(product: product, ts: _ts),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key key,
    @required this.product,
    @required TextStyle ts,
  })  : _ts = ts,
        super(key: key);

  final Product product;
  final TextStyle _ts;

  @override
  Widget build(BuildContext context) {
    return _ProductCard(product: product, ts: _ts);
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    Key key,
    @required this.product,
    @required TextStyle ts,
  })  : _ts = ts,
        super(key: key);

  final Product product;
  final TextStyle _ts;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: GridTile(
        child: ProductImage(product.thumbnail),
        footer: ProductTileBar(product, _ts),
      ),
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
        _productPrice(product, textstyle),
      ],
    );
  }
}

Text _productPrice(Product product, TextStyle textStyle) {
  return Text(
    (product.price == null)
        ? "0"
        : product.price.toStringAsFixed(
            product.price.truncateToDouble() == product.price ? 0 : 2),
    style: textStyle,
    textAlign: TextAlign.right,
  );
}

class ProductTileBar extends StatelessWidget {
  final Product _product;
  final TextStyle _textStyle;

  ProductTileBar(this._product, this._textStyle);

  @override
  Widget build(BuildContext context) {
    return GridTileBar(
      title: Text(_product.description),
      subtitle: _productPrice(_product, _textStyle),
      trailing: Text(_product.condition),
      backgroundColor: Colors.black54,
    );
  }
}

class ProductImage extends StatelessWidget {
  final String imageurl;

  ProductImage(this.imageurl);

  @override
  Widget build(BuildContext context) {
    return Container(
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
