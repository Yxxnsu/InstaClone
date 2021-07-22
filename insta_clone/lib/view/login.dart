import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/view/home.dart';

import '../start.dart';

class LoginPage extends StatelessWidget {
  
  final mainColor = Colors.black;
  final defaultStyle = TextStyle(color: Colors.white);
  String? _inputID;
  String? _inputPW;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: body(context),
    );
  }

  body(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(205, 72, 107, 1.0),
            Color.fromRGBO(188, 42, 141, 1.0)
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Instagram',
                style: GoogleFonts.cookie(
                  fontSize: 50, 
                  color: Colors.white
                ),
              ),
              SizedBox(height: 30,),
              _buildTextIDForm('Username'),
              SizedBox(height: 20,),
              _buildTextPWForm('Password'),
              SizedBox(height: 20,),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  _buildTextIDForm(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        onChanged: (text) {
          _inputID = text;
        },                              
        decoration: InputDecoration(         
          labelText: text,          
          labelStyle: defaultStyle,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),                         
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),             
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

   _buildTextPWForm(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        onChanged: (text) {
          _inputPW = text;
        },                
        obscureText: true,
        decoration: InputDecoration(         
          labelText: text,
          labelStyle: defaultStyle,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),                         
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),             
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  _buildButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: ()=> {            
            if(_inputID == null || _inputPW == null){
              Get.snackbar('LOGIN ERROR', 'Please put ID & PW',snackPosition: SnackPosition.BOTTOM, colorText: Colors.white,),
            }
            else if(_inputID != null && _inputPW != null){
              Get.to(()=> StartPage()), 
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical:16),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),            
              border: Border.all(color: Colors.white70),
            ),
            child: Text(
              'LOGIN',
              style:defaultStyle,
              textAlign: TextAlign.center,
            ),          
          ),
        ),
        SizedBox(height: 20),
        Text('Forgot Password? Need more Help?', style: defaultStyle),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Divider(thickness: 1),),            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('O', style: defaultStyle),
            ),
            Expanded(child: Divider(thickness: 1,),),
          ],
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                FontAwesomeIcons.facebook,
                size: 30,
                color: Colors.white,
              ),
            ),
            Text(
              'insta login with facebook',
              style: defaultStyle.copyWith(fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
    );
  }
}
