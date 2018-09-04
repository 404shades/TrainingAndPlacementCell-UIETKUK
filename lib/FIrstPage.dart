import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_placement/Cookies.dart';
import 'package:training_placement/Gradients.dart';
import 'package:training_placement/NoticePanel.dart';
import 'package:training_placement/TrainingPlacementForm.dart';
import 'package:training_placement/WebView.dart';
import 'package:training_placement/twopanels.dart';

class HomePageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
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
   var email = "null";
   var displayName = "null";
   var displayPicture = "https://www.google.com/";


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
                      backgroundImage: new NetworkImage("http://www.kuk.ac.in/userfiles/image/Prof_%20K_C_%20Sharma%20KU%20Vice-Chancellor%20Photo.JPG"),
                      radius: 34.0,
                      
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
                      backgroundImage: new NetworkImage("http://www.kuk.ac.in/userfiles/image/Prof_%20K_C_%20Sharma%20KU%20Vice-Chancellor%20Photo.JPG"),
                      radius: 34.0,
                      
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
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(

              accountName: Text(displayName,style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w700),),
              accountEmail: Text(email,style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w500),),
              currentAccountPicture: new CircleAvatar(backgroundImage: NetworkImage(displayPicture),),
              decoration: BoxDecoration(
                 color: Colors.black
              ),
              
                        
            ),
            new Divider(),
            new ListTile(
              title: Text("Home"),
              trailing: new Icon(Icons.forward),
            ),
            new ListTile(
              title: Text("ERP Panel"),
              trailing: new Icon(
                Icons.report
              ),
              onTap: _erpPanel,
            ),
            new ListTile(
              title: Text("My Account"),
            ),
            new ListTile(
              title: Text("Training and Placement Form"),
              onTap: ()=>Navigator.push(context,new MaterialPageRoute(
                builder: (context)=>new TrainingForm(user: user,)
              )),
            ),
            new ListTile(
              title: Text("Contact Us"),
              
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