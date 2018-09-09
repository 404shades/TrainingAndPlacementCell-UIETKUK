import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_placement/FIrstPage.dart';
import 'package:training_placement/Users.dart';

class UserDetails extends StatefulWidget {
  final FirebaseUser user;

  UserDetails({Key key, @required this.user}) : super(key:key);
  @override
  _UserDetailsState createState() => new _UserDetailsState(user);
}

class _UserDetailsState extends State<UserDetails> {
  String _rollNumber;
  String _class10marks;
  String _class10rollNumber;
  String _class12marks;
  String _class12rollNumber;
  String _dateOfBirth;
  String _phoneNumber;
  bool flag_added = false;
  bool _submitting =  false;

  final FirebaseUser user;
  _UserDetailsState(this.user);
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

  final TextEditingController textEditingController = new TextEditingController();
  final DocumentReference reference = Firestore.instance.collection("Users").document();
  void _submit(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      Users user1 = new Users(user.displayName, _rollNumber, user.email, _class10marks, _class10rollNumber, _class12marks, _class12rollNumber, _dateOfBirth, _phoneNumber);
      performBackendSaveUserProfile(user1);
    }
  }

  void performBackendSaveUserProfile(Users user2){
    if(!flag_added){
    Firestore.instance.runTransaction((Transaction transaction) async{
        CollectionReference collectionReference = Firestore.instance.collection("Users");
        await collectionReference.add({
          "email": user.email.toString(),
          "rollNumber": _rollNumber,
          "date_of_birth": _dateOfBirth,
          "class10marks": _class10marks,
          "class_10roll": _class10rollNumber,
          "class12marks" : _class12marks,
          "class12roll": _class12rollNumber,
          "mobile": _phoneNumber
        });
        flag_added=true;
        _toggleState();
        Navigator.of(context).pushReplacementNamed('/firstScreen');
    });
    }
  }

  void _toggleState(){
    setState(() {
          _submitting = !_submitting;
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(32.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new CircleAvatar(
                  backgroundImage: new NetworkImage(user.photoUrl),
                  radius: 38.0,
                ),
                new Padding(padding: const EdgeInsets.all(8.0),),
                new Text("Hello! ${user.displayName.split(" ")[0]}",style: new TextStyle(fontWeight: FontWeight.bold,
                fontSize: 21.0
                ),)
              ],
            ),
          ),
          _submitting && !flag_added? new Center(child: const CircularProgressIndicator(),) :
          new Container(
              padding: const EdgeInsets.all(14.0),
              child: new Card(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(12.0)),
                elevation: 24.0,
              child: new Container(
                padding: const EdgeInsets.all(18.0),
                child: new Form(
                  autovalidate: true,
                  
                  key: formKey,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Roll Number"
                        ),
                        keyboardType: TextInputType.number,
                        validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                        onSaved: (val)=>_rollNumber=val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Class 10 Roll Number"
                        ),
                        keyboardType: TextInputType.number,
                        validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                        onSaved: (val)=>_class10rollNumber=val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Class 10 Marks"
                        ),
                        keyboardType: TextInputType.number,
                        validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                        onSaved: (val)=>_class10marks=val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Class 12 Roll Number"
                        ),
                        keyboardType: TextInputType.number,
                        validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                        onSaved: (val)=>_class12rollNumber=val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Class 12 Marks"
                        ),
                        keyboardType: TextInputType.number,
                        validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                        onSaved: (val)=>_class12marks=val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Date of Birth"
                        ),
                        keyboardType: TextInputType.datetime,
                        validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                        onSaved: (val)=>_dateOfBirth=val,
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Enter Phone Number"
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                        onSaved: (val)=> _phoneNumber=val,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                      )
                      ,new RaisedButton(
                        child: new Text("Submit The Data",style: new TextStyle(color: Colors.white),),
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(32.0)),
                        color: Colors.black,
                        
                        onPressed: (){ 
                          _toggleState();
                          _submit();}
                      ),
                    ],
                  ),
            ),
              ),
              ),
          ),
          new Container(
            padding: const EdgeInsets.all(24.0),
            child: new Text(
              "*Note You can't Update your details afterwards. Please confirm before clicking Submit",
              style: new TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),
            ),
          )
        ],
      )
    );
  }
}