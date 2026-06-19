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
Future<ProductModel> createProduct(ProductModel newProduct, String userToken) async {
    final url = Uri.parse('$_baseurl/products');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // TIER 1 SECURITY: Attach the secure token to the request envelope
          'Authorization': 'Bearer $userToken',
        },
        body: json.encode(newProduct.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> decodedData = json.decode(response.body);
        return ProductModel.fromJson(decodedData);
      } 
      // TIER 1 SECURITY: Handle explicit authorization rejections gracefully
      else if (response.statusCode == 403) {
        throw Exception('Access Denied: You do not have permission to add products.');
      } else if (response.statusCode == 401) {
        throw Exception('Session Expired: Please log in again.');
      } else {
        throw Exception('Failed to save product: Server error (${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}