import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../../services/themeprovider.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'About the Nanosat',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 22,
              color: Theme.of(context).textTheme.headline1.color),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).iconTheme.color),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/nanosat.png'),
                SizedBox(height: 10),
                Text('The term “nanosatellite” or “nanosat” is usually applied to the name of an artificial satellite with a wet mass between 1 and 10 kg (2.2–22 lb). “CubeSats” (cubesatellite, cube satellite) are a type of nanosatellites defined by the CubeSat Design Specification (CSD), unofficially called CubeSat standard.'),

                Text('The nano-satellite will help Kenya predict and mitigate agricultural disasters, including the locust menace that has debilitated parts of the country in the last two years.')
              ],
            
          ),
        ),
      ),
    );
  }
}
