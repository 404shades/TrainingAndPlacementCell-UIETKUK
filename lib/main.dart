import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:training_placement/FillDataUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main(){
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
      title: "Training and Placement App",
      home: new HomeApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => new _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();
FirebaseUser user;
bool _submitting = false;
bool _checkUserEmailPresent = false;


Future<FirebaseUser> _signIn() async{
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  GoogleSignInAuthentication authentication = await googleSignInAccount.authentication;

  user = await auth.signInWithGoogle(
    idToken: authentication.idToken,
    accessToken: authentication.accessToken
  );
  print("USer Name ${user.displayName}");
  print(user.photoUrl);
  return user;
   
}

void _signout(){
  _checkUserEmailPresent=false;
  googleSignIn.signOut();
  print("Signed Out");
  
}

void _toggleSubmitState(){
  setState(() {
      _submitting = !_submitting;
    });
}



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: const EdgeInsets.all(30.0),
        child: new Center(
          child: _submitting? const CircularProgressIndicator(): Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                child: new Text("Google Login",style: new TextStyle(color: Colors.white),),
                onPressed: () { 
                  _toggleSubmitState();
                  _signIn().then((FirebaseUser user) async
                { 
                   try{
                   await Firestore.instance.collection("Users").where('email',isEqualTo:user.email)
                  .getDocuments().then((documents_query){
                    print(documents_query.documents.length);
                    documents_query.documents.length!=0?_checkUserEmailPresent=true:_checkUserEmailPresent=false;
                    
                  });
                  }catch(e){
                    print("Aree Baba");
                    _checkUserEmailPresent = false;

                  }
                  _toggleSubmitState(); 
                  print(_checkUserEmailPresent);
                  if(!_checkUserEmailPresent){
                  await Navigator.push(context, new MaterialPageRoute(
                    builder: (context)=> new UserDetails(user: user)
                  ));
                  }
                }).catchError((e)=> print(e));},
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.lightBlue
              ),
              new Padding(padding: const EdgeInsets.only(top: 24.0)),
              new RaisedButton(
                child: new Text("Sign Out", style: new TextStyle(color: Colors.white),),
                onPressed: ()=> _signout(),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.purple,
              )
            ],
          ),
        ),
      ),
    );
  }
}