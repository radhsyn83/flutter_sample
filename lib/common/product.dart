class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});

  static List<Product> list() => [
        Product(
            name: "Product 1", price: 120000, image: "assets/sample/prod1.png"),
        Product(
            name: "Product 2", price: 160000, image: "assets/sample/prod2.png"),
        Product(
            name: "Product 3", price: 90000, image: "assets/sample/prod3.png"),
        Product(
            name: "Product 4", price: 100000, image: "assets/sample/prod4.png"),
      ];
}
