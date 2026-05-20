import 'dart:convert';
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
  }



