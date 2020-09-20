class Product {
  String title, thumbnail;
  double price;
  String url;

  Product(this.title, this.thumbnail, this.price, this.url);

  factory Product.fromJson(Map<String, dynamic> json) {
    dynamic price;
    if (json['sellPrice'] is int) {
      price = json['sellPrice'].toDouble();
    } else {
      price = json['sellPrice'];
    }
    return Product(
      json['boxName'],
      json['imageUrls']["large"],
      price,
      "https://uk.webuy.com/product-detail?id=${json['boxId']}",
    );
  }
}
