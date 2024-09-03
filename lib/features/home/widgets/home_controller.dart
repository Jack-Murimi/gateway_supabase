import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentPageIndex = 0.obs;

  void changePage(int index) {
    currentPageIndex.value = index;
  }
}
