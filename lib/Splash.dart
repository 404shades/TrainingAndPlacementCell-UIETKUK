import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _naviagateToNew();

    }
    _naviagateToNew() async{
      
      user = await auth.currentUser();
      if(user==null){
        Navigator.of(context).pushReplacementNamed('/loginScreen');
        return;
      }
      bool _check = await _checkForAlreadyRegistered();
      if(_check==true){
        Navigator.of(context).pushReplacementNamed('/firstScreen');
      }
      else{
        Navigator.of(context).pushReplacementNamed('/loginScreen');
      }
    }
    Future<bool> _checkForAlreadyRegistered() async{
      bool _userAlreadyRegistered=false;
      final SharedPreferences _pref = await SharedPreferences.getInstance();
      String _email =    _pref.getString("user_email");
      print("ROhan MAlik WOOOOHOOOOO  +  $_email");
      print(_email);
      if(_email==null){
        return false;
      }
      await Firestore.instance.collection("Users").where('email',isEqualTo:_email)
      .getDocuments().then((documents_query){
          print("Lets Check BUddy ${documents_query.documents.length}");
          if(documents_query.documents.length==1){
            _userAlreadyRegistered = true;
          }
      });
      return _userAlreadyRegistered;
    }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Center(
              child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/Kurukshetra_University_logo.png",width: 150.0,height:180.0,),
                  new Padding(
                    padding: const EdgeInsets.only(top:12.0),
                  ),
                  new Text("University Institute Of Engineering and Technology",style: new TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),),
                  new Padding(
                    padding: const EdgeInsets.only(top:10.0),
                  ),
                  new Text(
                    "Kurukshetra University, Kurukshetra",
                    style: new TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            )
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(backgroundColor: Colors.black,),
                  new Padding(padding: const EdgeInsets.only(top:10.0),),
                  new Text("Loading....")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}