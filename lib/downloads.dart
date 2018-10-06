import 'package:flutter/material.dart';
import 'package:training_placement/Gradients.dart';

class DownloadsPanel extends StatefulWidget {
  @override
  _DownloadsPanelState createState() => _DownloadsPanelState();
}

class _DownloadsPanelState extends State<DownloadsPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:new AppBar(
        title:Text("Downloads",style:TextStyle(color:Colors.white,fontFamily: 'Poppins')),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: IconThemeData(color:Colors.white),
        
      ),
      body: new Padding(
        padding:const EdgeInsets.only(top:16.0),
        child: new Container(
          child:SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new Container(
                  height: 306.0,
                  child:new Card(
                    elevation: 2.0,
                    child:new Row(
                      children: <Widget>[
                        new Container(
                          height: 306.0,
                          width:206.0,
                          child: new Image.asset("assets/mayukh.jpg",fit: BoxFit.cover,),

                        ),
                        new Flexible(
                          child:new Column(
                          
                          
                          
                          children: <Widget>[
                            new SizedBox(height: 12.0,),
                            new Text("Mayukh",style:TextStyle(
                              fontSize:20.0,
                              fontFamily:"Poppins",
                              fontWeight:FontWeight.w700,
                              
                            ),
                            textAlign: TextAlign.center,

                            ),
                            new Padding(
                              padding:const EdgeInsets.all(10.0),

                            ),
                            new Expanded(
                              
                              flex:3,
                              child: new Container(
                                padding:const EdgeInsets.only(left:14.0,right: 10.0),
                                child: new Text("Mayukh is an official Magazine of University Institute of Engineering and Technology, Kurkshetra University Kurukshetra that is punlished this year in the month of April. It includes all the events of year 2017 and a Student's Section which revolves around the creativity of our students.",
                              textAlign: TextAlign.justify,
                              )
                              )
                              
                              ),
                              new Container(
                padding: const EdgeInsets.only(left: 5.0,right: 5.0),
                margin: const EdgeInsets.only(left: 5.0,right: 5.0),
              width: double.infinity,
              height: 25.0,
              decoration: new BoxDecoration(
                gradient: pinkRedGradient,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(14.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 2.0)
                  ),
                  
                ]
                
              ),
              child: new MaterialButton(
                onPressed: ()=>null,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Download ",style: TextStyle(color: Colors.white),),
                    new Padding(padding: const EdgeInsets.only(left: 14.0)),
                    new Icon(Icons.cloud_download,color: Colors.white,)
                  ],
                ),
              ),
            ),
            new SizedBox(height:17.0)
                          ],
                        )
                        )
                      ],
                    )
                  )
                )
              ],
            )
          )
        )
      )
    );
  }
}