import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../services/product_service.dart';

// We specify that this Bloc accepts ProductEvents and outputs ProductStates
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // We instance our service layer so the Bloc can use it
  final ProductService _productService = ProductService();

  // The constructor sets the very first state when the app boots up
  ProductBloc() : super(ProductInitialState()) {
    
    // We register a listener: when a "SaveProductEvent" happens, run the _onSaveProduct function
    on<SaveProductEvent>(_onSaveProduct);
  }

  // The core business logic function
  Future<void> _onSaveProduct(
    SaveProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    // 1. Instantly emit the Loading State so the UI displays a spinner
    emit(ProductLoadingState());

    try {
      // 2. Use the service layer to send data over the internet
      // 'event.productToSave' is the data passed directly from the text fields
      final savedProduct = await _productService.createProduct(event.productToSave);

      // 3. If the server says 201 Created, emit the Success State with the data object
      emit(ProductSuccessState(createdProduct: savedProduct));
      
    } catch (error) {
      // 4. If the service throws a network or server exception, catch it
      // Emit the Error State with the text message to display to the user
      emit(ProductErrorState(errorMessage: error.toString()));
    }
  }
}