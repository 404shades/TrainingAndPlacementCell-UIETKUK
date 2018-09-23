import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum _TrainingType{
 Training,
 Internship,
 Both 
}

typedef DemoItemBodyBuilder<T> = Widget Function(DemoItem<T> item);
typedef ValueToString<T> = String Function(T value);  

class ModifyTnpForm extends StatefulWidget {
  final QuerySnapshot document_query;
  ModifyTnpForm({Key key,@required this.document_query}): super(key:key);
  @override
  _ModifyTnpFormState createState() => _ModifyTnpFormState(document_query);
}

class _ModifyTnpFormState extends State<ModifyTnpForm> {
  final QuerySnapshot document_query;
  _ModifyTnpFormState(this.document_query);
   final scaffoldKey = new GlobalKey<ScaffoldState>();
  List<DemoItem<dynamic>> _demoItems;
  String _updatedName ;
  String _updatedInstituteName;
  String _updatedTrainingType;
  DateTime _updatedJoiningDate;

  DateTime convertToDate(String input){
    try{
      var d =  new DateFormat.yMMMMEEEEd().parseStrict(input);
      return d;
    }
    catch(e){
      return null;
    }
  }
  bool isvalid(){
    if((_updatedName.trim().isEmpty || _updatedInstituteName.trim().isEmpty)){
        return false;
    }
    return true;

  }
  void _performBackendUpdate() async{
    DocumentReference reference =  document_query.documents[0].reference;
    print("ROORORO $isvalid()");
    if(isvalid()){
    await reference.updateData({
        'name': _updatedName,
        'TrainingInstituteName':_updatedInstituteName,
        'TrainingType':_updatedTrainingType,
        'dateOfJoining':_updatedJoiningDate 
    });

    }
    else{
      showMessage("Form Not Valid Please Check You must have saved any feild empty");
    }
    
  }
  void showMessage(String message){
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        backgroundColor: Colors.black,
        content: new Text(message,style: TextStyle(color: Colors.white)),
      )
    );
  }
  _TrainingType _findTrainingType(String value){
    if(value=="Training"){
      return _TrainingType.Training;
    }
    else if(value=='Internship'){
      return _TrainingType.Internship;
    }
    else if(value=='Training & Internship Both'){
      return _TrainingType.Both;
    }
    else{
      return null;
    }
  }
  Future _chooseDate(BuildContext context,String initialDateString, TextEditingController _controller) async{
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
  
  @override
  void initState() {
  super.initState();
  _updatedName = document_query.documents[0].data['name'];
  _updatedInstituteName = document_query.documents[0].data['TrainingInstituteName'];
  _updatedJoiningDate = document_query.documents[0].data['dateOfJoining'];
  _updatedTrainingType = document_query.documents[0].data['TrainingType'];
  _demoItems = <DemoItem<dynamic>>[
    DemoItem<String>(
      name: "Your Name",
      value: document_query.documents[0].data['name'],
      hint: "Change Your Name",
      valueToString: (String value)=>value,
      builder: (DemoItem<String> item){
        void close(){
          setState(() {
                      item.isExpanded = false;
                    });
        }
        return Form(
          autovalidate: true,
          child: Builder(
            builder: (BuildContext context){
                return CollapsibleBody(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  onSave: (){Form.of(context).save();close();},
                  onCancel: (){Form.of(context).reset();close();},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: item.textController,
                      decoration: InputDecoration(hintText: item.hint
                      ,labelText: item.name
                      ),
                      validator: (val){
                        print("OPOSPOSPOPSOPSOPSOP $val");
                        val.trim().isEmpty?"Please Input Some Values":null;},
                      onSaved: (String value) {item.value = value;_updatedName = value;},
                    ),
                  ),
                );
            },
          ),
        );
      },
    ),
    DemoItem<String>(
      name: 'Training Institute',
      value: document_query.documents[0].data['TrainingInstituteName'],
      hint: "Change Training Institute Name",
      valueToString: (String value)=>value,
      builder: (DemoItem<String> item){
        void close(){
          setState(() {
                      item.isExpanded  = false;
                    });
        }
        return Form(
          child: Builder(
            builder: (BuildContext context){
              return CollapsibleBody(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                onSave: (){Form.of(context).save();close();},
                onCancel: (){Form.of(context).reset();close();},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: item.textController,
                    decoration: InputDecoration(
                      hintText: item.hint,
                      labelText: item.name,
                      
                    ),
                    validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                    onSaved: (String value){item.value = value;_updatedInstituteName = value;},
                  ),
                ),
              );
            },
          ),
        );
      } 
    ),
    DemoItem<_TrainingType>(
      name: "Training Type",
      value: _findTrainingType(document_query.documents[0].data['TrainingType']),
      hint: "Change Training Type",
      valueToString: (_TrainingType item)=>
        item.toString().split('.')[1],
        builder: (DemoItem<_TrainingType> item){
          void close(){
            setState(() {
                          item.isExpanded = false;
                        });
          }
          return Form(
            child: Builder(
              builder: (BuildContext context){
                return CollapsibleBody(
                  onSave: (){Form.of(context).save();close();},
                  onCancel: (){Form.of(context).reset();close();},
                  child: FormField<_TrainingType>(
                    initialValue: item.value,
                    onSaved: (_TrainingType result){item.value = result;_updatedTrainingType=result.toString().split('.')[1];},
                    builder: (FormFieldState<_TrainingType> field){
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Radio<_TrainingType>(
                                value: _TrainingType.Training,
                                groupValue: field.value,
                                onChanged: field.didChange,
                              ),
                              const Text('Training',style: TextStyle(
                              color: Colors.black,

                              ),),
                              
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Radio<_TrainingType>(
                                value: _TrainingType.Internship,
                                groupValue: field.value,
                                onChanged: field.didChange,
                              ),
                              const Text('Internship',style: TextStyle(
                              color: Colors.black,

                              ),),
                            ]
                      
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Radio<_TrainingType>(
                                value: _TrainingType.Both,
                                groupValue: field.value,
                                onChanged: field.didChange,
                              ),
                               const Text('Both',style: TextStyle(
                              color: Colors.black,

                              ),),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),

          );
        }
      
    ),
    DemoItem<DateTime>(
      name: 'Joining Date',
      value: document_query.documents[0].data['dateOfJoining'],
      hint: "Change Joining Date",
      valueToString: (DateTime value)=>value.toString().split(":")[0].split(" ")[0],
      builder: (DemoItem<DateTime> item){
        void close(){
          setState(() {
                      item.isExpanded  = false;
                    });
        }
        return Form(
          child: Builder(
            builder: (BuildContext context){
              return CollapsibleBody(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                onSave: (){Form.of(context).save();close();},
                onCancel: (){Form.of(context).reset();close();},
                child: FormField<DateTime>(
                  initialValue: item.value,
                  onSaved: (DateTime result){item.value = result;},
                  builder: (FormFieldState<DateTime> field){
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Expanded(
                          child: new TextFormField(
                            controller: item.textController,
                            decoration: InputDecoration(
                              hintText: item.hint,
                              labelText: item.name
                            ),
                            enabled: false,
                            validator: (val)=>val.trim().isEmpty?"Please Input Some Values":null,
                            onSaved: (String value){item.value = convertToDate(value);_updatedJoiningDate = convertToDate(value);},
                          ),
                        ),
                        new IconButton(
                          icon: new Icon(Icons.date_range),
                          tooltip: "Choose Date",
                          onPressed: ((){
                              _chooseDate(context, item.textController.text, item.textController);
                          }),
                        )
                      ],
                    );
                  },
                )
              );
            },
          ),
        );
      } 
    ),
  ];
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(document_query.documents[0].data['name'],style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w700),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
            margin: const EdgeInsets.all(24.0),
            child: ExpansionPanelList(
              expansionCallback: (int index,bool isExpanded){
                setState(() {
                                  _demoItems[index].isExpanded = !isExpanded;
                                });
              },
              children: _demoItems.map((DemoItem<dynamic> item){
                return ExpansionPanel(
                  isExpanded: item.isExpanded,
                  headerBuilder: item.headerBuilder,
                  body: item.build()
                );
              }).toList(),
            ),
          ),
          new RaisedButton(
            color: Colors.black,
            child: Text("Update Changes",style: TextStyle(color: Colors.white,fontFamily: "Poppins",fontSize: 16.0,fontWeight: FontWeight.w400),),
            onPressed:(){
              _performBackendUpdate();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
             

          )
            ],
          )
          
        ),
      ),
    );
  }
}

class DualHeaderWithHint extends StatelessWidget {

  const DualHeaderWithHint({
    this.name,
    this.value,
    this.hint,
    this.showHint
  });
  
  final String name;
  final String value;
  final String hint;
  final bool showHint;

  Widget _crossFade(Widget first,Widget second,bool isExpanded){
    return AnimatedCrossFade(
      firstChild: first,
      secondChild: second,
      firstCurve: const Interval(0.0, 0.6,curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0,curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState: isExpanded?CrossFadeState.showSecond:CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.only(left: 24.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(name,style: TextStyle(fontSize: 15.0),),
            ),
          ),
        ),
        Expanded(flex: 3,
        child: Container(
          margin: const EdgeInsets.only(left: 24.0),
          child: _crossFade(
            Text(value,style: TextStyle(fontSize: 15.0),)
            ,Text(hint,style: TextStyle(fontSize: 15.0),)
            , showHint),
        ),)
      ],
    );
  }
}

class CollapsibleBody extends StatelessWidget {
   final EdgeInsets margin;
  final Widget child;
  final VoidCallback onSave;
  final VoidCallback onCancel;
   const CollapsibleBody({
    this.margin = EdgeInsets.zero,
    this.child,
    this.onSave,
    this.onCancel
});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 24.0,right: 24.0,bottom: 24.0)-margin,
          child: Center(
            child: DefaultTextStyle(
              style: TextStyle(fontSize: 15.0),
              child: child,
            ),
          ),
        ),
        const Divider(height: 1.0,),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 8.0),
                child: FlatButton(
                  onPressed: onCancel,
                  child: Text("CANCEL",style: TextStyle(color: Colors.black54,fontSize: 15.0,fontWeight: FontWeight.w500),),
                )
                ,
              ),
              Container(margin: const EdgeInsets.only(right: 8.0),
              child: FlatButton(
                onPressed: onSave,
                child: Text("SAVE"),
              ),),

            ],
          ),
        )
      ],
    );
  }
}

class DemoItem<T> {
  DemoItem({
    this.name,
    this.value,
    this.hint,
    this.builder,
this.valueToString
  }):textController  = TextEditingController(text: valueToString(value));
  final String name;
  final String hint;
  final TextEditingController textController;
  final DemoItemBodyBuilder<T> builder;
  final ValueToString<T> valueToString;
  T value;
  bool isExpanded = false;
  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return DualHeaderWithHint(
        name: name,
        value: valueToString(value),
        hint: hint,
        showHint: isExpanded
      );
    };
  }

Widget build() => builder(this);
}

