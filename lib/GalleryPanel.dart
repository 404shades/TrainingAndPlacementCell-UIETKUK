import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(2, 2),
  const StaggeredTile.count(2, 1),
  const StaggeredTile.count(1, 2),
  const StaggeredTile.count(1, 1),
];
List<Widget> _tiles =  <Widget>[
   PlacementTile("assets/1.jpg","Infosys- 2018"),
   PlacementTile("assets/2.jpg","Adani- 2016"),
   PlacementTile("assets/3.jpg","Adani- 2016"),
   PlacementTile("assets/4.jpg","Wipro- 2015"),
 
];
class GalleryPanel extends StatefulWidget {
  @override
  _GalleryPanelState createState() => _GalleryPanelState();
}

class _GalleryPanelState extends State<GalleryPanel> {



  List<Container> galleryItems = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Gallery",style: TextStyle(color: Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w600),),
        centerTitle: true,
        backgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      ),
      body: new Padding(
        padding: const EdgeInsets.only(top:14.0),
        child: new GridView.count(
          crossAxisCount: 3,
          children: _tiles,
          scrollDirection: Axis.vertical,

        )
      )
    );
  }
}

class PlacementTile extends StatelessWidget {
  PlacementTile(this.image,this.imageCaption);
  final String image;
  final String imageCaption;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.asset(image,fit: BoxFit.cover,),
          new Positioned(
            left:0.0,
            right:0.0,
            bottom:0.0,
            child: new Container(
              decoration:new BoxDecoration(
                gradient:LinearGradient(
                  begin:Alignment.topCenter,
                  end:Alignment.bottomCenter,
                  colors:[
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ]
                )
              ),
              padding: const EdgeInsets.all(14.0),
              child:Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Text(imageCaption,style: TextStyle(
                    color:Colors.white,
                    fontSize:15.0
                  ),),
                  
                ],
              )
              
            ),
          )
        ],
      ),
    );
  }
}