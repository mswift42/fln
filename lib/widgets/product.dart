import 'package:fln/product.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductsWidget extends StatelessWidget {
  final List<Product>? products;

  const ProductsWidget(this.products, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products!.isEmpty) {
      return const Center(
        child: Text("No results found :("),
      );
    }
    return GridView.extent(
        maxCrossAxisExtent: 320.0,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 1.0,
        children: products!.map((i) => ProductWidget(i)).toList());
  }
}

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _ts = Theme.of(context).textTheme.bodyText2;
    return GestureDetector(
      onTap: () => _launchUrl(product.url),
      child: Card(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
                constraints: const BoxConstraints(
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
                        product.description!,
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
  final TextStyle? textstyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            product.condition!,
            style: textstyle,
          ),
        ),
        Text(
          (product.price == null)
              ? "0"
              : product.price!.toStringAsFixed(
                  product.price!.truncateToDouble() == product.price ? 0 : 2),
          style: textstyle,
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}

class ProductImage extends StatelessWidget {
  final String? imageurl;

  const ProductImage(this.imageurl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Image.network(
        imageurl!,
        fit: BoxFit.contain,
        cacheHeight: 236,
        cacheWidth: 186,
      ),
    );
  }
}

_launchUrl(String url) async {
  await launch(url);
}
