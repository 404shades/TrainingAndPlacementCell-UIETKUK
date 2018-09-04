import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TrainingForm extends StatefulWidget {
  final FirebaseUser user;

  TrainingForm({Key key,@required this.user}): super(key:key);
  @override
  _TrainingFormState createState() => _TrainingFormState(user);
}

class _TrainingFormState extends State<TrainingForm> {
  final FirebaseUser user;
  int _radioValue=0;
  _TrainingFormState(this.user);
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
       child: new ListView(
         padding: const EdgeInsets.only(top:38.0),
         children: <Widget>[
           new Column(
             children: <Widget>[
               new Container(
                 child: new Column(
                   children: <Widget>[
                     new CircleAvatar(
                       backgroundImage: NetworkImage(user.photoUrl),
                       maxRadius: 48.0,
                     ),
                     new Padding(padding: const EdgeInsets.only(top:18.0),),
                     new Text(
                       user.displayName,
                       style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),
                     )
                   ],
                 ),
               ),
               new Container(padding: const EdgeInsets.all(12.0),
               child: Card(
                 elevation: 18.0,
                 shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(14.0),
                
               ),
                child: new Container(
                  padding: const EdgeInsets.all(16.0),
                  child: new Form(
                    key:formKey,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Your Name "
                          ),
                          keyboardType: TextInputType.text,
                          validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Roll Number"
                          ),
                          keyboardType: TextInputType.number,
                          validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Training Institute Name"
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        new Text("Select Semester"),
                        new Padding(padding: const EdgeInsets.only(top:5.0),),
                        
                        
                      ],
                    ),
                  ),
                ),
               ))
             ],
           )
         ],
       ), 
      )
    );
  }
}