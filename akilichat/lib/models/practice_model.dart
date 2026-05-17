
class ProductModel{
  final String name;
  final String ID;
  final String description;
  final double price;
  final String imageUrl;

ProductModel({
  required this. name,
  required this.ID,
  required this.description,
  required this. price,
  required this. imageUrl,
});
factory ProductModel.fromJson(Map<String, dynamic>json){
  return ProductModel(
    name: json['name'] as String,
    ID: json['ID'] as String,
    description: json['description'] as String,
    price: (json['price'] as num).toDouble(),
    imageUrl: json ['imageUrl'],
  );
}
  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'ID': ID,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

