import 'package:get/get.dart';

class MainController extends GetxController {
  // الحالة النشطة للصفحة
  var selectedIndex = 0.obs;

  // تحديث الصفحة النشطة
  void updateIndex(int index) {
    selectedIndex.value = index;
  }
}
