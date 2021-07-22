import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:insta_clone/service/controller.dart';
import 'package:insta_clone/view/home.dart';
import 'package:insta_clone/view/mypage.dart';

import 'model/dummyRepo.dart';

class StartPage extends StatelessWidget {
  
  final stateController controller = Get.put(stateController());
  List<Widget> pageView = [
    HomePage(),
    MyPage(),    
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<stateController>(      
      builder: (_) {
        return Scaffold(                  
          body: pageView[_.currentIndex!],
          bottomNavigationBar: bottomNavigationBar(context),
        );
      }
    );
  }
  Widget bottomNavigationBar(BuildContext context) {
    return GetBuilder<stateController>(
      builder: (_) {
        return Theme(data: Theme.of(context).copyWith(canvasColor: Theme.of(context).canvasColor),
          child: BottomNavigationBar(
            elevation: 10.0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.home), label: ""),
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.search,), label: ""),
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.plusSquare, ),label: ""),
              BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.heart,), label: ""),
              BottomNavigationBarItem(icon: ClipOval(child: Container(width: 24,height: 24,child: Image.asset(dummyList[0]["profileURL"],fit:BoxFit.fill,),),),label:"",),
            ],
              currentIndex: _.currentIndex!,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black54,
              onTap: (index)=> controller.selectPage(index),
          ),
        );
      }
    );
  }
}