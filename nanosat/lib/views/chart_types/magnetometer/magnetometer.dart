import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';

class MagnetometerCharts extends StatefulWidget {


  @override
  _MagnetometerChartsState createState() => _MagnetometerChartsState();
}

class _MagnetometerChartsState extends State<MagnetometerCharts> {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://ksa-nanosat.herokuapp.com'),
  );
  var socketData;
   var log = Logger();
   String str;
  //  var magneticCompass = {
  //    "y":
  //  };
  
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if(snapshot.hasData) { 
              socketData = snapshot.data;
              
              if(socketData.runtimeType != String){
                 str = new String.fromCharCodes(socketData);
                 print('Data is:');
                 var splitString = str.split('/n');
                 String newString = splitString[0];
                 String removeWeirdChar = newString.replaceAll('\u0000', '');
                 var splitByNewLine = removeWeirdChar.split('\n');
                //   var zeroth = splitByNewLine[0].split(' ');
                //  log.i(zeroth[2]);
                log.i(splitByNewLine[0]);
              }
              
            }
            return Text('${str ?? "Loading data"}');
            
          })])
    );
  }
}





