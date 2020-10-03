class Product {
  String description;
  String condition;
  String thumbnail;
  double price;
  String url;

  Product(
      this.description, this.condition, this.thumbnail, this.price, this.url);

  factory Product.fromJson(Map<String, dynamic> json) {
    dynamic price;
    if (json['sellPrice'] is int) {
      price = json['sellPrice'].toDouble();
    } else {
      price = json['sellPrice'];
    }
    var title = json['boxName'].split(',');
    var description = title[0];
    var condition = (title.length == 2) ? title[1] : '?';

    return Product(
      description,
      condition,
      json['imageUrls']["large"],
      price,
      "https://uk.webuy.com/product-detail?id=${json['boxId']}",
    );
  }
}
