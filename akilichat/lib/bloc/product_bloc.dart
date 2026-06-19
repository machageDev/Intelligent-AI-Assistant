import 'package:akilichat/service/api_practice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService _productService = ProductService();

  ProductBloc() : super(ProductInitialState()) {
    on<SaveProductEvent>(_onSaveProduct);
  }

  Future<void> _onSaveProduct(
    SaveProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    // 1. TIER 1 SECURITY: Local Role-Based Access Validation
    // We check the user's role before doing any expensive network work
    if (event.userRole != 'admin' && event.userRole != 'vendor') {
      emit(ProductErrorState(
        errorMessage: 'Security Access Denied: Your account role (${event.userRole}) does not have permission to add new products.',
      ));
      return; // Stop execution immediately! Do not hit the server.
    }

    // 2. Visual Update: Show the spinner
    emit(ProductLoadingState());

    try {
      // 3. TIER 1 SECURITY: Pass both the product data AND the secure JWT Token
      final savedProduct = await _productService.createProduct(
        event.productToSave,
        event.userToken, // Secured server validation
      );

      // 4. Success Emit
      emit(ProductSuccessState(createdProduct: savedProduct));
      
    } catch (error) {
      // 5. Clean Error Capture
      emit(ProductErrorState(errorMessage: error.toString()));
    }
  }
}