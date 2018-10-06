import 'package:flutter/material.dart';

class OurTeam extends StatefulWidget {
  @override
  _OurTeamState createState() => _OurTeamState();
}

class _OurTeamState extends State<OurTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Our Team",style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w600),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      
      ),
      body: ListView(
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.all(3.0),
                child: new Card(
                  
                    child: new Column(

                      children: <Widget>[
                        new SizedBox(height: 10.0,),
                        new Text("Our T&P Incharge",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
                        new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Flexible(
                          flex: 1,
                          child: new Container(
                            padding: EdgeInsets.only(top:26.0,bottom: 26.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new CircleAvatar(backgroundImage: AssetImage("assets/nm.jpg"),
                                maxRadius: 54.0,
                                backgroundColor: Colors.white,
                                ),
                                new SizedBox(height: 16.0,),
                                new Text("Mr. Nikhil Marriwala",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0
                                ),)
                              ],
                            ),
                          ),
                        ),
                        new Flexible(
                          flex: 1,
                          child: new Container(
                            padding: EdgeInsets.only(top:26.0,bottom: 26.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new CircleAvatar(backgroundImage: AssetImage("assets/sa.jpg"),
                                maxRadius: 54.0,
                                backgroundColor: Colors.white,
                                ),
                                new SizedBox(height: 16.0,),
                                new Text("Dr. Sanjeev Ahuja",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0
                                ),)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                      ],
                    )
                ),
              ),
              new Container(
                padding: EdgeInsets.all(3.0),
                child: new Card(
                  
                    child: new Column(

                      children: <Widget>[
                        new SizedBox(height: 10.0,),
                        new Text("Our Student Coordinators",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
                        new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Flexible(
                          flex: 1,
                          child: new Container(
                            padding: EdgeInsets.only(top:26.0,bottom: 26.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new CircleAvatar(backgroundColor: Colors.white,
                                 backgroundImage: AssetImage("assets/avat.png"),
                                maxRadius: 54.0,
                                ),
                                new SizedBox(height: 16.0,),
                                new Text("Mr. Bhushan Kumar",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0
                                ),)
                              ],
                            ),
                          ),
                        ),
                        new Flexible(
                          flex: 1,
                          child: new Container(
                            padding: EdgeInsets.only(top:26.0,bottom: 26.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new CircleAvatar(backgroundColor: Colors.white,
                                maxRadius: 54.0,
                                backgroundImage: AssetImage("assets/avat.png"),
                                ),
                                new SizedBox(height: 16.0,),
                                new Text("Mr. Aman Kumar",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0
                                ),)
                              ],
                            ),
                          ),
                        ),
                        new Flexible(
                          flex: 1,
                          child: new Container(
                            padding: EdgeInsets.only(top:26.0,bottom: 26.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new CircleAvatar(backgroundColor: Colors.white,
                                 backgroundImage: AssetImage("assets/avat.png"),
                                maxRadius: 54.0,
                                ),
                                new SizedBox(height: 16.0,),
                                new Text("Mr. Shubham Sharma",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                      ],
                    )
                ),
              ),
              new Container(
                padding: EdgeInsets.all(3.0),
                child: new Card(
                  
                    child: new Column(

                      children: <Widget>[
                        new SizedBox(height: 10.0,),
                        new Text("Contact Us",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w500),),
                        new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Flexible(
                          flex: 1,
                          child: new Container(
                            padding: EdgeInsets.only(top:26.0,bottom: 26.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Icon(
                                  Icons.email
                                ),
                                new SizedBox(height: 16.0,),
                                new Text("tpouiet@kuk.ac.in",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0
                                ),)
                              ],
                            ),
                          ),
                        ),
                        new Flexible(
                          flex: 1,
                          child: new Container(
                            padding: EdgeInsets.only(top:26.0,bottom: 26.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new Icon(Icons.phone_iphone),
                                new SizedBox(height: 16.0,),
                                new Text("+91-9729999805",style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0
                                ),)
                              ],
                            ),
                          ),
                        ),
                        // new Flexible(
                        //   flex: 1,
                        //   child: new Container(
                        //     padding: EdgeInsets.only(top:26.0,bottom: 26.0),
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //       children: <Widget>[
                        //         new CircleAvatar(backgroundColor: Colors.white,
                        //          backgroundImage: AssetImage("assets/avat.png"),
                        //         maxRadius: 54.0,
                        //         ),
                        //         new SizedBox(height: 16.0,),
                        //         new Text("Mr. Shubham Sharma",style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 16.0
                        //         ),)
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                      ],
                    )
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}