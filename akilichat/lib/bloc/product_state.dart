

import 'package:akilichat/models/practice_model.dart';

abstract class ProductState{}

class ProductInitialState extends ProductState{}

class ProductLoadingState extends ProductState{}

class ProductSuccessState extends ProductState{
  final ProductModel createdProduct;
  ProductSuccessState({required this.createdProduct});
  
}
class ProductErrorState extends ProductState{
  final String errorMessage;
  ProductErrorState({required this.errorMessage});
}

