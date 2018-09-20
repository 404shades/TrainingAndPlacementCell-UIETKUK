import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_placement/Gradients.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';


class NoticeWidget extends StatefulWidget {
  @override
  _NoticeWidgetState createState() => _NoticeWidgetState();
}

class _NoticeWidgetState extends State<NoticeWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      
      
      backgroundColor: Colors.white,
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.black,
        child: new Icon(Icons.arrow_back_ios,color: Colors.white),
        onPressed: ()=> Navigator.of(context).pop(),
        elevation: 25.00,
        highlightElevation: 14.0,
        tooltip: "Go Back",
        
      ),
      body: new Notices(context),
    );
  }
}


class Notices extends StatelessWidget {
  final BuildContext context;
  Notices(this.context);

  String _getDate(DocumentSnapshot document){
    String timestamp = document['timestamp'].toString().substring(0,10);
    var arr = timestamp.split("-");
    String answer = arr[2] + "/" + arr[1] + "/" + arr[0];
    return answer;
  }
   

  String _isAttachmentAvailable(DocumentSnapshot document){
    if(document['download_link']!=null){
      return "Attachment Available";
    }
    return "";
  }

  _launchUrl(String url) async{
      if(await canLaunch(url)){
        await launch(url);
      }
      else{
        print("No Boy");
      }
  }

  void _showModalSheet(String title,String subtitle,String url){
    showModalBottomSheet(
      context: context,
      builder: (builder){
        return new Container(
          padding: const EdgeInsets.all(18.0),
          decoration: new BoxDecoration(
            color: Colors.white
            
          ),

          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: double.infinity,
                child: new Center(
                  child: new Text(title,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    
                    fontSize: 20.0
                  ),textAlign: TextAlign.justify,),
                )
              ),
              
          new Padding(padding: const EdgeInsets.only(top:14.0),),
          new Divider(),
          
          new Flexible(
            flex: 3,
            child: new Container(
            padding: const EdgeInsets.all(14.0),
            child: new Center(
              child: new Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16.0,
                  
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ),
          ),
          new Flexible(
            flex: 1,
            child: new Center(
              child: new Container(
                padding: const EdgeInsets.only(left: 38.0,right: 38.0),
                margin: const EdgeInsets.only(left: 58.0,right: 58.0),
              width: double.infinity,
              height: 30.0,
              decoration: new BoxDecoration(
                gradient: pinkRedGradient,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 14.0)
                  ),
                  
                ]
                
              ),
              child: new MaterialButton(
                onPressed: ()=>_launchUrl(url),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Download Attachment",style: TextStyle(color: Colors.white),),
                    new Padding(padding: const EdgeInsets.only(left: 14.0)),
                    new Icon(Icons.cloud_download,color: Colors.white,)
                  ],
                ),
              ),
            ),
            )
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
        if(!snapshot.hasData) return new Center(child: new CircularProgressIndicator(backgroundColor: Colors.black,),);
        return new ListView(
          padding: const EdgeInsets.all(12.0),
          
          children: snapshot.data.documents.map((document){
            return Container(

              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  new Padding(padding:const EdgeInsets.only(top:18.00)),
                
                  new Container(
                  
              
              decoration: new BoxDecoration(
                gradient: blackBlueGradient,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
                    spreadRadius: 10.0
                  )
                ]
                

              ),
              
              
              
              child: new ListTile(
                title: new Text(document['Heading'],style:new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:14.0,
                  color: Colors.white,
                  fontFamily: 'Poppins'
                  
                ),
                textAlign: TextAlign.justify,
                ),
                subtitle: new Text(_isAttachmentAvailable(document),style: new TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300
                  
                  
                ),),
                trailing: new Container(
                  width: 98.0,
                  height: 25.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(14.0),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: new Offset(0.0, 10.0),
                        spreadRadius: 6.0                  )
                    ]
                  ),
                  child: new Center(
                    child: new Text(_getDate(document),
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'

                    ),),
                  ),
                  
                ),
                onTap: ()=>_showModalSheet(document['Heading'],document['SubHeading'],document['download_link']),
              ),
              
            ),
            new Divider()
                ],
              )
            );
          }).toList(),
        );
      },
    );
  }
}