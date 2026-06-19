import 'package:akilichat/models/practice_model.dart';

abstract class ProductEvent {}

class SaveProductEvent extends ProductEvent {
  final ProductModel productToSave;
  
  // TIER 1 SECURITY: New fields carried from the user session
  final String userToken; // Holds the secure JWT encryption string for the API headers
  final String userRole;  // Holds the access tier string (e.g., 'admin', 'vendor', 'customer')

  SaveProductEvent({
    required this.productToSave,
    required this.userToken,
    required this.userRole,
  });
}