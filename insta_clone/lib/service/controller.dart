import 'package:get/get.dart';

class stateController extends GetxController{
  
  int? currentIndex;


  selectPage(int index){

    currentIndex = index;
    update();
      
  }

}