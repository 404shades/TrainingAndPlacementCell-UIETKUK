import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter/material.dart';

class WebView extends StatefulWidget {
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  

  @override
  void initState(){
    super.initState();
    FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
    flutterWebviewPlugin.onUrlChanged.listen((String url){
      print("kokoki $url");
    });
  }
  @override
  Widget build(BuildContext context) {
    
    return WebviewScaffold(

      appBar: AppBar(
        title: Text("ERP Panel",style: TextStyle(color:Colors.white,fontFamily: 'Poppins',fontWeight: FontWeight.w800),),
        backgroundColor: Colors.black,

        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      url: "http://www.uietkuk.in/",
      withZoom: true,
      withJavascript: true,
      withLocalStorage: true,
      withLocalUrl: true,
      

    );
  }
}