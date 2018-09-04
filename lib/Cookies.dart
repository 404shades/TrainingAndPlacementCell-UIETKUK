import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';



var drawer = new Drawer(
  child: new ListView(
    children: <Widget>[
      new UserAccountsDrawerHeader(
        accountName: new Text("Rohan"),
        decoration: new BoxDecoration(
          color: Colors.white
        ),
        accountEmail: new Text("imrohanmalik@gmail.com"),
      )
    ],
  )
);

