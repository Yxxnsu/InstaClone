import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_clone/model/dummyRepo.dart';

class MyPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              dummyList[0]['userId'],
              style: TextStyle(
                color: Colors.black
              ),
            ),            
            SizedBox(width: 8,),
            Icon(Icons.arrow_drop_down,color: Colors.black),
          ],
        ),          
        actions: [          
          Center(child: FaIcon(FontAwesomeIcons.plusSquare,color: Colors.black)),
          SizedBox(width: 16,),
          Center(child: Icon(Icons.menu,color: Colors.black)),
          SizedBox(width: 16,),
        ],
      ),    
      body: body(context),
    );
  }

  body(BuildContext context){

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeadProfile(),
            SizedBox(height: 20,),     
            _buildText(),       
            SizedBox(height: 20,),            
            _buildButton(),
            SizedBox(height: 10,),            
            Divider(thickness: 1,),
            SizedBox(height: 30,),
            _buildMyPicture(context)
          ],
        ),
      ),
    );
  }

  _buildHeadProfile(){

    List<Widget> menuList = [
      menuItem('게시물', 0),
      menuItem('팔로워', 14),
      menuItem('팔로잉', 7),  
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,      
      children: [
        ClipOval(
          child: Container(
            width: 90,
            height: 90,
            child: Image.asset(
              dummyList[0]['profileURL'],  
              fit:BoxFit.fill,            
            ),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: menuList,                     
          ),
        ),
      ],
    );
  }

  Widget menuItem(String title, int num){

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )
        ),
        SizedBox(height: 8,),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          )
        )
      ]
    );
  }

  _buildText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${dummyList[0]['name']}',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          'Emulator is IOS✨\nKOREA🇰🇷\nThis is very Good :)',
          style: TextStyle(
            fontSize: 12,
            fontWeight:FontWeight.w400,
          ),
        )
      ],
    );
  }

  _buildButton(){
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(            
            onPressed: (){},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: Colors.white,
              shape: RoundedRectangleBorder(                
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.black.withOpacity(0.2)),
              )
            ),
            child: Text('프로필 편집',style:TextStyle(color: Colors.black)),            
          ),
        ),
        SizedBox(width: 5,),
        ElevatedButton(                                  
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: Colors.white,            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: Colors.black.withOpacity(0.2)),
            )
          ),
          child: Icon(Icons.arrow_drop_down_outlined,color:Colors.black),
        ),
      ],
    );
  }

  _buildMyPicture(BuildContext context){    
    return Container(
      height: 1000,
      child: GridView.builder(
        shrinkWrap: true,      
        itemCount: 100,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,        
        ),      
        itemBuilder: (context,idx){
          return Container(
            width: 100,
            height: 100,
            child: Image.network(
              dummyList[idx % 3]["url_image_post"],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }  

}