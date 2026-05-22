import 'dart:convert';
import 'dart:math';
import 'package:akilichat/models/practice_model.dart';
import 'package:http/http.dart' as http ;



class ProductService {
  final String _baseurl = "";


  Future<List<ProductModel>> fetchProducts() async {
    final Url = Uri.parse('$_baseurl/products');
    try{
      final response = await http.get(Url);

      if(response.statusCode == 200) {
        final List<dynamic>decodeData = json.decode(response.body);
        return decodeData.map((item) => ProductModel.fromJson(item)).toList();
      }else{
        throw Exception('failed to load data: server returned status ${response.statusCode}');
      } 
    }
    catch (e) { 
      throw Exception('network error occured:$e');
      }
    }
    Future<ProductModel> createProduct(ProductModel newProduct) async {
      final Url = Uri.parse('$_baseurl/products');

      try{
        final response = await http.post(
          url,
          headers:{
            'Content-Type':'application/json',
          },
          body: json.encode(newProduct.toJson()),
        );
        if(response.statusCode == 201){
          final Map<String,dynamic> decodedData = json.decode(response.body);
          return ProductModel.fromJson(decodedData);

        }else {
          throw Exception('failed to save data:Server returned status ${response.statusCode}');

        } 
        catch (e) {
          
          throw Exception('Network error occured while saving data:$e');

        }
      }
    }
}   
  



