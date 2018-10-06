import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_placement/ContactUs.dart';
import 'package:training_placement/Cookies.dart';
import 'package:training_placement/FilledFormHtml.dart';
import 'package:training_placement/GalleryPanel.dart';
import 'package:training_placement/Gradients.dart';
import 'package:training_placement/NoticePanel.dart';
import 'package:training_placement/RecruitersPage.dart';
import 'package:training_placement/TrainingPlacementForm.dart';
import 'package:training_placement/WebView.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:training_placement/downloads.dart';
import 'package:training_placement/twopanels.dart';

class HomePageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      
      showSemanticsDebugger: false,
      title: "UIET KUK",
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
        primaryColorDark: Colors.black,
        accentColor: Colors.black,
        
      ),
      home: new BackDropApp(),
      routes: <String,WidgetBuilder>{
        '/notifications':(BuildContext context)=>new NoticeWidget(),
        '/erppanel': (BuildContext context)=>new WebView(),

      },
    );
  }
}
class BackDropApp extends StatefulWidget {
  @override
  _BackDropAppState createState() => _BackDropAppState();
}

class _BackDropAppState extends State<BackDropApp> {

   FirebaseUser user;
   RemoteConfig remoteConfig;
   var email = "null";
   var displayName = "null";
   var displayPicture = "https://www.google.com/";  
   bool enablingForm = false;
   


      void _notifications(){
          Navigator.of(context).pushNamed('/notifications');
      }
      void _erpPanel(){
        Navigator.of(context).pushNamed('/erppanel');
      }
      void _getUser() async{
        user = await FirebaseAuth.instance.currentUser();
        print("OOOLALALALLA $user");
        setState(() {
                  email = user.email;
                  displayName = user.displayName;
                  displayPicture = user.photoUrl;
                });
      }

      @override
      void initState(){
        super.initState();
        _getUser();
        setUpRemoteConfig();
      }
      
    Future<void> setUpRemoteConfig() async{
      remoteConfig =await RemoteConfig.instance;
      await remoteConfig.setConfigSettings(new RemoteConfigSettings(debugMode: true));
      await remoteConfig.setDefaults(<String,dynamic>{
        'enablingForm':false
      });
      try{
      await remoteConfig.fetch(expiration: const Duration(seconds: 0));
      await remoteConfig.activateFetched().then((value){
        print("Pokemon $value");
        print("PokemonNew ${remoteConfig.getBool("enablingForm")}");
        setState(() {
                  enablingForm = remoteConfig.getBool('enablingForm');
                });
       
        
      });

      
      print("LOOLLL${remoteConfig.getBool('enablingForm')}");
      
      }on FetchThrottledException catch(exception){
        print(exception);
      }

    }

    
      
    

  Widget topArea(BuildContext context){
    return new Container(
      height: 252.0,
      child: new Stack(
        children: <Widget>[
          new ClipPath(
            clipper: new ArcCliper(),
            child: new Container(
              height: double.infinity,
              
              // child: Image.asset("assets/uiet_pic.jpg"),
              decoration: new BoxDecoration(
                gradient: pinkRedGradient
              ),
            ),
          ),
          
        ],
      ),
    );
  }
 var text = "University Institute of Engineering & Technology (UIET) was established by Kurukshetra University in 2004 with objective to develop as a University Institute of Engineering & Technology (UIET) was established by Kurukshetra University in 2004 with objective to develop as a Centre of Excellence and offer quality technical education and to undertake research in Engineering & Technology. Presently, the institute is offering four B. Tech (Computer Science & Engineering, Electronics and Communication Engineering, Biotechnology and Mechanical Engineering) and eight M. Tech. course";
  Widget content(BuildContext context){
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.all(14.0),
            child: new Card(
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(14.0)),
            elevation: 19.0,
            child: new Container(
              child: new Column(
                children: <Widget>[
                  new Center(
                    child: new Text("About UIET",style: new TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'

                    ),),
                  ),
                  new Padding(padding: const EdgeInsets.all(2.0),),
                  new Container(
                    padding: const EdgeInsets.all(14.0),
                    child: new Text(
                      
                      "University Institute of Engineering & Technology (UIET) was established by Kurukshetra University in 2004 with objective to develop as a University Institute of Engineering & Technology (UIET) was established by Kurukshetra University in 2004 with objective to develop as a Centre of Excellence and offer quality technical education and to undertake research in Engineering & Technology. Presently, the institute is offering four B. Tech (Computer Science & Engineering, Electronics and Communication Engineering, Biotechnology and Mechanical Engineering) and eight M. Tech. course ",
                      
                      softWrap: true,
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            )
          )
          ),
          new Padding(padding: const EdgeInsets.only(top:6.0),),
          new Container(
            padding: const EdgeInsets.all(14.0),
            child: new Card(
              shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
              elevation: 19.0,
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    leading: new CircleAvatar(
                      backgroundImage: AssetImage("assets/dir.jpeg"),
                      radius: 34.0,
                      backgroundColor: Colors.white,
                      
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text("Prof Dr. C.C. Tripathi"),
                    subtitle: new Text("Director, UIET KUK"),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(14.0),
                    child: new Text(
                      "It gives me immense pleasure to introduce University Institute of Engineering and Technology (UIET) which was established in 2004 in the campus of Kurukshetra University. It was established with a motive ‘MIND TO MARKET’ so as to achieve excellence in the key areas of engineering and to produce talented and committed human resources driven by the spirit of innovation and team work. Presently the institute imparts training in the four key branches of Engineering namely Computer Science Engineering, Electronics and Communication Engineering, Bio-Technology and Mechanical Engineering. We offer both graduate and post graduate degrees in these branches of Engineering to about 1600 talented students from all parts of India having top ranks in AIEEE.",
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
          ),
          new Padding(padding: const EdgeInsets.only(top: 6.0),),
          new Container(
            padding: const EdgeInsets.all(14.0),
            child: new Card(
              shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
              elevation: 19.0,
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    leading: new CircleAvatar(
                      backgroundImage: AssetImage("assets/vcku.jpeg"),
                      radius: 34.0,
                      backgroundColor: Colors.white,
                      
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text("Dr. Kailash Chandra Sharma"),
                    subtitle: new Text("Vice Chancellor, Kurukshetra University"),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(14.0),
                    child: new Text(
                      "It gives me immense pleasure to introduce University Institute of Engineering and Technology (UIET) which was established in 2004 in the campus of Kurukshetra University. It was established with a motive ‘MIND TO MARKET’ so as to achieve excellence in the key areas of engineering and to produce talented and committed human resources driven by the spirit of innovation and team work. Presently the institute imparts training in the four key branches of Engineering namely Computer Science Engineering, Electronics and Communication Engineering, Bio-Technology and Mechanical Engineering. We offer both graduate and post graduate degrees in these branches of Engineering to about 1600 talented students from all parts of India having top ranks in AIEEE.",
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
          ),
          new Container(
            padding: const EdgeInsets.all(14.0),
            child: new Card(
              shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
              elevation: 19.0,
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    leading: new CircleAvatar(
                      backgroundImage: AssetImage("assets/nm.jpg"),
                      radius: 34.0,
                      backgroundColor: Colors.white,
                      
                    ),
                    trailing: new CircleAvatar(
                      backgroundImage: AssetImage("assets/sa.jpg"),
                      radius: 34.0,
                      backgroundColor: Colors.white,
                    ),
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text("Mr. Nikhil Marriwala and Dr. Sanjeev Ahuja"),
                    subtitle: new Text("Training and Placement Incharge"),
                  ),
                  new Container(
                    padding: const EdgeInsets.all(14.0),
                    child: new Text(
                      "It gives me immense pleasure to know that our University Institute of Engineering & Technology (UIET) is bringing out the placement brochure for the engineering graduates completing their course studies in 2011. It is a matter of pride to know that teachers and students of UIET have strived hard to establish healthy traditions of dedicated work and perfect training towards achieving high standards. Over the years , since its inception the institute has grown with excellent infrastructure for teaching of programmes in different engineering disciplines.",
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
          ),
          new SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }

  Future<bool> _onBackPressed(){
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          
          title: new Text("Do You really want to exit the app?",style: TextStyle(fontFamily: "Poppins"),),
          actions: <Widget>[
            new FlatButton(
              onPressed: ()=>Navigator.pop(context,true),
              child: new Text("Yes",style: TextStyle(color: Colors.blue,fontSize: 19.0),),
              
            ),
            new FlatButton(
              onPressed: ()=>Navigator.pop(context,false),
              child: new Text("No",style: TextStyle(color: Colors.blue,fontSize: 19.0),),
              
            )
          ],
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(


      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(

              accountName: Text(displayName,style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontWeight: FontWeight.w700),),
              accountEmail: Text(email,style: TextStyle(color: Colors.black,fontFamily: 'Poppins',fontWeight: FontWeight.w500),),
              currentAccountPicture: new CircleAvatar(backgroundImage: NetworkImage(displayPicture),),
              decoration: BoxDecoration(
                 color: Colors.white,

              ),
              
              
                        
            ),
            new Divider(),
            // new ListTile(
            //   title: Text("Home"),
            //   trailing: new Icon(Icons.home,color: Colors.black,),
              
            // ),
            new ListTile(
              title: Text("ERP Panel"),
              trailing: new Icon(
                Icons.laptop_mac,
                color: Colors.black,
              ),
              onTap: _erpPanel,
            ),
            new ListTile(
              title: Text("Gallery"),
              trailing: Icon(Icons.picture_in_picture,color: Colors.black,),
              onTap: ()=>Navigator.push(context,new MaterialPageRoute(
                builder: (context)=>new GalleryPanel()
              )),
            ),
            enablingForm?
            new ListTile(
              title: Text("Training and Placement Form"),
              onTap: ()=>Navigator.push(context,new MaterialPageRoute(
                builder: (context)=>new TrainingForm(user: user,)
              )),
              trailing: Icon(Icons.redeem,color: Colors.black,),
              enabled: enablingForm,
            ):new SizedBox(height: 0.0,),
            new ListTile(
              title: Text("Downloads"),
              trailing:Icon(Icons.cloud_download,color: Colors.black,),
              onTap: ()=>Navigator.push(context, new MaterialPageRoute(
                builder:(context)=>new DownloadsPanel()
              )),
            ),
            new ListTile(
              title: Text("Contact Us"),
              onTap: ()=>Navigator.push(context, new MaterialPageRoute(
                builder: (context)=>new OurTeam()
              )),
              trailing: Icon(Icons.contact_mail,color: Colors.black,),
              
            ),
            new ListTile(
              title: Text("Placement records"),
              onTap: ()=>Navigator.push(context, new MaterialPageRoute(
                builder: (context)=>new RecruitersWidget()
              )),
              trailing: Icon(Icons.record_voice_over,color: Colors.black,),
            ),
            new ListTile(
              title: new Row(
                children: <Widget>[
                  new Icon(Icons.copyright,size: 16.0,),
                  new Text(" UIET Kurukshetra"),
                  
                ],
              ),
              subtitle: Text("  A 4O4Shades Product"),
              
            )
          ],
          
        ),

        elevation: 14.0,
        semanticLabel: "Rohan",
      ),
      appBar: new AppBar(
        title:  new Text("UIET KUK",style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w600),),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.notifications,color: Colors.white,),
            onPressed: _notifications,
          )
        ],
        elevation: 6.0,
      ),
      body: new ListView(
        children: <Widget>[
          topArea(context),
          new Padding(padding: const EdgeInsets.only(top:12.0),),
          content(context)

        ],
      ),
    ),
    );
  }
}


class ArcCliper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = new Path();
    path.lineTo(0.0, size.height / 2 + 30);

    var firstControlPoint = new Offset(size.width / 5, size.height);
    var firstPoint = new Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);
    var secondControlPoint =
        new Offset(size.width - (size.width / 5), size.height);
    var secondPoint = new Offset(size.width, size.height / 2 + 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
return path;
  }
  @override
    bool shouldReclip(CustomClipper<Path> oldClipper) {
      // TODO: implement shouldReclip
      return false;
    }
}