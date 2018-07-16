import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class NoticeWidget extends StatefulWidget {
  @override
  _NoticeWidgetState createState() => _NoticeWidgetState();
}

class _NoticeWidgetState extends State<NoticeWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Notices(context),
    );
  }
}


class Notices extends StatelessWidget {
  final BuildContext context;
  Notices(this.context);

  void _showModalSheet(String title,String subtitle){
    showModalBottomSheet(
      context: context,
      builder: (builder){
        return new Container(
          color: Colors.black,
          padding: const EdgeInsets.all(18.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Card(
            color: Colors.black,
            elevation: 24.0,
            child: new Text(
              title,
              style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
          new Padding(padding: const EdgeInsets.only(top:18.0),),
          new Card(
            color: Colors.black,
            elevation: 24.0,
            child: new Text(
              subtitle,
              style: new TextStyle(
                fontSize: 16.0,
                color: Colors.white
              ),
            ),
          )
            ],
          )

        );
      }
      
    );
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("Notifications").orderBy("timestamp",descending: true).snapshots(),
      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
        if(!snapshot.hasData) return new Text("Loading");
        return new ListView(
          padding: const EdgeInsets.all(12.0),
          reverse: true,
          children: snapshot.data.documents.map((document){
            return new Card(
              elevation: 4.0,
              color: Colors.blueGrey,
              child: new ListTile(
                title: new Text(document['Heading'],style:new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:14.0
                )),
                onTap: ()=>_showModalSheet(document['Heading'],document['SubHeading']),
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            );
          }).toList(),
        );
      },
    );
  }
}