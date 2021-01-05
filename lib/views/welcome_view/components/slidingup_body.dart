import 'dart:ui';
import 'variables.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

// widgets relating to sliding up panel body.

Widget slidingupBody(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/startview.jpg"),
            fit: BoxFit.cover),
      ),
      child: Stack(
        fit: StackFit.loose,
        children: [
          Positioned.fill(
            top: 75,
            child: Align(
              alignment: Alignment.topCenter,
              child: logoImageBody(),
            ),
          ),
          Positioned.fill(
            bottom: 180,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: loginButtonBody(),
            ),
          ),
          Positioned.fill(
            bottom: 125,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: registerButtonBody(),
            ),
          ),
        ],
      ),
    );
  }

  Widget logoImageBody() {
    return Text(
      '''PLENTY 
OF PICS''',
      style: TextStyle(
          shadows: <Shadow>[
            Shadow(
              offset: Offset(1.0, 1.0),
              blurRadius: 3.0,
              color: Color.fromARGB(255, 0, 0, 0),
            )
          ],
          color: Color.fromARGB(255, 224, 234, 255),
          fontSize: 48,
          fontFamily: "Syncopate"),
    );
  }

  Widget loginButtonBody() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          child: SizedBox(
            width: 185,
            height: 45,
            child: RaisedButton(
              elevation: 7.0,
              textColor: Colors.white,
              child: Text(
                "Log in",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              color: Color.fromARGB(150, 59, 55, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide.none,
              ),
              onPressed: () => pc.open(),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerButtonBody() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          child: SizedBox(
            width: 185,
            height: 45,
            child: FlatButton(
              textColor: Colors.black,
              child: Text(
                "Register",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              color: Color.fromARGB(125, 255, 255, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide.none,
              ),
              onPressed: () async {
                const url = 'https://unsplash.com/join';
                if (await canLaunch(url)) {
                  await launch(url, forceWebView: true);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
          ),
        ),
      ),
    );
  }