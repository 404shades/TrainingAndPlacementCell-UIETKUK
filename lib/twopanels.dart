import 'package:flutter/material.dart';
import 'package:training_placement/Gradients.dart';
import 'package:training_placement/UIETStack.dart';
class TwoPanels extends StatefulWidget {

  final AnimationController controller;

  TwoPanels({this.controller});

  @override
  _TwoPanelsState createState() => _TwoPanelsState();
}

class _TwoPanelsState extends State<TwoPanels> {
  static const header_height = 32.0;
 
  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints){
    final height = constraints.biggest.height;
    final backPanelHeight = height-header_height;
    final frontPanelHeight = -header_height;

    return new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0)
    ).animate(new CurvedAnimation(parent: widget.controller,curve: Curves.linear));
  }

  Widget bothPanels(BuildContext context,BoxConstraints constraints){

    final ThemeData theme = Theme.of(context);
    return new Container(
      child: new Stack(
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(
              gradient: bluePinkGradient
            ),
            child: new Center(
              child:   new Text("Back Panel",
              style: new TextStyle(fontSize: 24.0,color: Colors.white),
              ),


            ),
          ),
          new PositionedTransition(
            rect: getPanelAnimation(constraints),
            child: new Material(
              elevation: 24.0,
              borderRadius: new BorderRadius.vertical(top: new Radius.elliptical(12.0, 15.0)),
              child: new UIETdetailstack(),
            ),
          )
        ],
      ),

    );

  }
  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
        builder: bothPanels,
    );
  }
}