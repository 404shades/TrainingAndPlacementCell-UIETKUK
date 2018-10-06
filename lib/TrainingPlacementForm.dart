import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:training_placement/FilledFormHtml.dart';
import 'package:training_placement/ModifyTrainingForm.dart';
import 'TrainingFormData.dart';


class TrainingForm extends StatefulWidget {
  final FirebaseUser user;
  
  TrainingForm({Key key,@required this.user}): super(key:key);
  @override
  _TrainingFormState createState() => _TrainingFormState(user);
}

class _TrainingFormState extends State<TrainingForm> {
  UserData userData  = new UserData();
  final FirebaseUser user;
  bool _checking = false;
  bool _previouslyAdded = false;
  bool _submittingForm = false;
  String _semseterValue='';
  String _trainingType = '';
  _TrainingFormState(this.user);
  QuerySnapshot documents_to_send;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  List<String> _values = <String>['','1st Semester','2nd Semester','3rd Semester','4th Semester','5th Semester','6th Semester','7th Semester','8th Semester'];
  List<String> _trTypes = <String>['','Internship','Training','Training & Internship Both'];

  @override
  void initState(){
    super.initState();
    _checking=true;
    _toggleState();
    
  }
  void _toggleState() async{
      bool _check = await _checkForAlreadyRegistered();
      print(_check);
      if(_check==true){
          setState(() {
                      _checking = false;
          _previouslyAdded = true;
                    });

      }
      else{
        setState(() {
                  _checking = false;
        _previouslyAdded = false;
                });
        

      }
  }
  
  Future<bool> _checkForAlreadyRegistered() async{
    bool _userAlreadyRegistered=false;
    await Firestore.instance.collection("TrainingForms").where('email',isEqualTo: user.email.toString())
    .getDocuments().then((_documentsQuery){
          documents_to_send = _documentsQuery;
        if(_documentsQuery.documents.length>=1){
          print("miioiioi");
          _userAlreadyRegistered = true;
        }
        else{
         _userAlreadyRegistered = false;
        }
    });
    return _userAlreadyRegistered;
  }

  final TextEditingController _controller = new TextEditingController();
  Future _chooseDate(BuildContext context,String initialDateString) async{
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString)??now;
    initialDate = (initialDate.year>=2017 && initialDate.isBefore(now)?initialDate:now);
    var result = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2025)

    );
    if (result==null){
      return;
    }
    setState(() {
          _controller.text = new DateFormat.yMMMMEEEEd().format(result);

        });
  }
  DateTime convertToDate(String input){
    try{
      var d =  new DateFormat.yMMMMEEEEd().parseStrict(input);
      return d;
    }
    catch(e){
      return null;
    }
  }

 void _saveForm(BuildContext context){
   final FormState form = formKey.currentState;
   if(!form.validate()|| userData.semester.trim().isEmpty||userData.trainingType.trim().isEmpty){
     showMessage('Form is not Valid! Please review and Correct ${userData.semester} and ${userData.trainingInstituteName}');
   }
   else{
     _showDialog(context,form);
   }
 }
 void _performBackendServerSave(FormState form){
   form.save();
   Firestore.instance.runTransaction((Transaction transaction) async{
      CollectionReference collectionReference =  Firestore.instance.collection("TrainingForms");
      await collectionReference.add({
        "email":user.email.toString(),
        "rollNumber":userData.rollNumber,
        "name":userData.name,
        "TrainingInstituteName":userData.trainingInstituteName,
        "Semester":userData.semester,
        "TrainingType":userData.trainingType,
        "dateOfJoining":userData.doj
      });
      
      
   });
 }
 DateTime expiryDate(){
   var today = new DateTime.now();
   var expiry = today.add(Duration(days: 55));
   return expiry;
 }
  void showLoadingDialog(BuildContext context){
     showDialog(
       barrierDismissible: false,
       context: context,
       builder: (BuildContext context){
         return AlertDialog(
           title: Text("Submitting......."),
           content: new Container(
             child: Column(
               children: <Widget>[
                 new CircularProgressIndicator(backgroundColor: Colors.black,),
                 new SizedBox(
                   height: 25.0,
                 ),
                 new Text("Your filled form will be mailed to you at ${user.email}"),
                 new SizedBox(height: 10.0),
                 new Text("Note* Please dont hit back while the form is saving")
               ],
             ),
           )
         );
       }
     );
   }
  void showMessage(String message){
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(backgroundColor: Colors.black,
      content: new Text(message,style: TextStyle(color: Colors.white),),)
    );
  }
  void _showDialog(BuildContext context,FormState form){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return AlertDialog(

          title: new Text("Hi ${user.displayName.split(" ")[0]}, Do you confirm the following Details"),
          content: new Text("Note* You Cant change the mentioned details once you click the save button"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Save"),
              onPressed:(){
                
                
                _performBackendServerSave(form);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
               
              form.reset();
              
              },
            ),
            new FlatButton(
              child: new Text("Close"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
  Widget showAddedDialog(BuildContext context){
        return AlertDialog(
          title: new Text("Hi, ${user.displayName.split(" ")[0]} You have already filled the Training Form once"),
          content: new Text("Now You can only update your Training Form upto ${expiryDate().toString().split(":")[0].split(" ")[0]}. You will receive your confirmed Training Letter form on ${user.email} after ${expiryDate().toString().split(" ")[0]}"),
          actions: <Widget>[
             new FlatButton(
              onPressed: ()=>Navigator.push(context, new MaterialPageRoute(
                builder: (context)=>new ModifyTnpForm(document_query:documents_to_send)
              )),
              child: new Text("Modify Details",style: new TextStyle(color: Colors.blueAccent),),
            ),
            new FlatButton(
              onPressed: ()=> Navigator.push(context, new MaterialPageRoute(
                builder: (context)=>new FilledForm(user: user) 
              )),
              child: new Text("Download",style: new TextStyle(color: Colors.blueAccent),),
            )
          ],
        );
  }

bool _isValidDob(String dob){
  if(dob.isEmpty) return false;
  var d = convertToDate(dob);
  return d!=null && d.isAfter(new DateTime.now());
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: _checking?new Container(child: Center(child: new CircularProgressIndicator(backgroundColor: Colors.black,),),):
      _previouslyAdded?showAddedDialog(context):
      new Container(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new TextFormField(
                          initialValue: user.displayName,
                          decoration: new InputDecoration(
                            labelText: "Enter Your Name "
                            
                          ),
                         
                          inputFormatters: [new LengthLimitingTextInputFormatter(20)],
                          keyboardType: TextInputType.text,
                          validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                          onSaved: (val)=>userData.name=val,
                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Roll Number"
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [new LengthLimitingTextInputFormatter(10)],
                          validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                           onSaved: (val)=>userData.rollNumber=val
                        ),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Training Institute Name"
                          ),
                          keyboardType: TextInputType.text,
                          inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                          validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                          onSaved: (val)=>userData.trainingInstituteName=val,
                        ),

  
                        new InputDecorator(
                          decoration: InputDecoration(
                            
                            labelText: "Select Semester"
                          ),
                          isEmpty: _semseterValue=='',
                          child: new DropdownButtonHideUnderline(
                            child: new DropdownButton<String>(
                                value: _semseterValue,
                                isDense: true,
                                onChanged: (String newValue){
                                  setState(() {
                                    userData.semester = newValue;
                                                 _semseterValue = newValue;                     
                                                                    });
                                },
                                items: _values.map((String value){
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                          ),
                        ),
                        
                        
                        ),
                        new InputDecorator(
                          decoration: InputDecoration(
                            labelText: "Select Training Type"
                          ),
                          isEmpty: _trainingType == '',
                          child: new DropdownButtonHideUnderline(
                            child: new DropdownButton<String>(
                              value: _trainingType,
                              isDense: true,
                              onChanged: (String newValue){
                                setState(() {
                                  userData.trainingType = newValue;
                                                                  _trainingType = newValue;
                                                                });
                              },
                              items: _trTypes.map((String value){
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                       new Row(
                         children: <Widget>[
                           new Expanded(
                             child: new TextFormField(
                               decoration: new InputDecoration(
                                 labelText: "Enter the Date of Joining"
                               ),
                               controller: _controller,
                               keyboardType: TextInputType.datetime,
                               enabled: false,
                               validator: (val)=>_isValidDob(val)?null:'Not A Valid Date',
                               onSaved: (val)=>userData.doj = convertToDate(val),
                               
                             ),
                           ),
                           new IconButton(
                             icon: new Icon(Icons.date_range),
                             tooltip: "Choose Date",
                             onPressed: ((){
                               _chooseDate(context, _controller.text);
                             }),
                           ),
                         ],
                       ),
                       new Padding(
                         padding: const EdgeInsets.all(19.0),

                       ),
                       new Center(
                         child: new Container(
                           height: 35.0,
                           width: 125.0,
                           decoration: BoxDecoration(
                             color: Colors.black,
                             shape: BoxShape.rectangle,
                             borderRadius: BorderRadius.circular(14.0),
                             boxShadow: <BoxShadow>[
                               new BoxShadow(
                                 color: Colors.black12,
                                 blurRadius: 10.0,
                                 offset: Offset(0.0, 10.0),
                                 spreadRadius: 0.0
                               )
                             ]

                           ),
                           child: new MaterialButton(
                             onPressed:()=>_saveForm(context),
                             child: new Center(
                               child: Text("Submit",style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w600,fontSize: 16.0),),
                             ),
                           ),
                         ),
                       ),
                       new SizedBox(
                         height: 14.0,
                       )
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