import 'package:flutter/material.dart';
import 'package:training_placement/NoticePanel.dart';
import 'package:training_placement/twopanels.dart';

class HomePageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue
      ),
      home: new BackDropApp(),
      routes: <String,WidgetBuilder>{
        '/notifications':(BuildContext context)=>new NoticeWidget(),

      },
    );
  }
}
class BackDropApp extends StatefulWidget {
  @override
  _BackDropAppState createState() => _BackDropAppState();
}

class _BackDropAppState extends State<BackDropApp> with SingleTickerProviderStateMixin{

  AnimationController controller;

  @override
    void initState() {
      // TODO: implement initState
      
      super.initState();
      controller = new AnimationController(vsync: this,duration: new Duration(microseconds: 1000),value: 1.0);

    }

    @override
      void dispose() {
        // TODO: implement dispose
        super.dispose();
        controller.dispose();
      }
      bool get isPageVisible{
        final AnimationStatus status  = controller.status;
        return status==AnimationStatus.completed||status==AnimationStatus.forward;
      }
      void _notifications(){
          Navigator.of(context).pushNamed('/notifications');
      }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:  new Text("UIET KUK"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.notifications,color: Colors.white,),
            onPressed: _notifications,
          )
        ],
        elevation: 0.0,
        leading: new IconButton(
          onPressed: (){
            controller.fling(velocity: isPageVisible?-5.0:5.0);
          },
          icon: new AnimatedIcon(
            icon: AnimatedIcons.arrow_menu,
            progress: controller.view,
          ),
        ),
      ),
      body: new TwoPanels(controller: controller,),
    );
  }
}