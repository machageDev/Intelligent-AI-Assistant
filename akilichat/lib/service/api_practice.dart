import 'dart:convert';
import 'package:akilichat/models/practice_model.dart';
import 'package:http/http.dart' as http;

class ProductService {
  // Add your actual base URL here
  final String _baseurl = "https://your-api-base-url.com";

  Future<List<ProductModel>> fetchProducts() async {
    final Uri url = Uri.parse('$_baseurl/products');
    try {
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> decodedData = json.decode(response.body);
        return decodedData.map((item) => ProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data: Server returned status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error occurred: $e');
    }
  }

  Future<ProductModel> createProduct(ProductModel newProduct) async {
    final Uri url = Uri.parse('$_baseurl/products');

    try {
      final http.Response response = await http.post(
        url, // Fixed: Changed from 'url' to 'Uri' parameter position
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(newProduct.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> decodedData = json.decode(response.body);
        return ProductModel.fromJson(decodedData);
      } else {
        throw Exception('Failed to save data: Server returned status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error occurred while saving data: $e');
    }
  }
}