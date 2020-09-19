class Product {
  String title, thumbnail;
  double price;
  String url;

  Product(this.title, this.thumbnail, this.price, this.url);

  factory Product.fromJson(Map<String, dynamic> json) {
    dynamic price;
    if (json['SellPrice'] is int) {
      price = json['SellPrice'].toDouble();
    } else {
      price = json['SellPrice'];
    }
    return Product(
      json['BoxName'],
      json['imageUrls']["large"],
      price,
      json['BoxId'],
    );
  }
}
