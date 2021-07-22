import 'package:get/get.dart';

class stateController extends GetxController{
  
  int? currentIndex = 0;


  selectPage(int index){

    currentIndex = index;
    update();
      
  }

}