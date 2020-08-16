class Product {
  String title, thumbnail;
  double price;
  String url;

  Product(this.title, this.thumbnail, this.price, this.url);

  factory Product.fromJson(Map<String, dynamic> json) {
    dynamic price;
    if (json['price'] is int) {
      price = json['price'].toDouble();
    } else {
      price = json['price'];
    }
    return Product(
      json['title'],
      json['thumbnail'],
      price,
      json['url'],
    );
  }
}
