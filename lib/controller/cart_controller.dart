import 'package:get/get.dart';

class CartController extends GetxController {
  var cartItems = [].obs;
  var totalPrice = 0.0.obs;

  void addToCart(
      String productId, String title, double price, String imageUrl) {
    // تحقق إذا المنتج موجود مسبقاً بالسلة
    var existingItem =
        cartItems.firstWhereOrNull((item) => item['id'] == productId);
    if (existingItem != null) {
      existingItem['quantity'] += 1;
    } else {
      cartItems.add({
        'id': productId,
        'title': title,
        'price': price,
        'image': imageUrl,
        'quantity': 1,
      });
    }
    calculateTotalPrice();
  }

  void updateQuantity(String productId, int quantity) {
    var item = cartItems.firstWhere((item) => item['id'] == productId);
    if (item != null) {
      item['quantity'] = quantity;
      calculateTotalPrice();
    }
  }

  void calculateTotalPrice() {
    totalPrice.value = cartItems.fold(
      0.0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }

  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item['id'] == productId);
    calculateTotalPrice();
  }
}
