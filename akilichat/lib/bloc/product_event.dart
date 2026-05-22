
import 'package:akilichat/models/practice_model.dart';

abstract class ProductEvent{}
class SaveProductEvent extends ProductEvent{
  final ProductModel productToSave;

  saveProductEvent({required this.productToSave});
}