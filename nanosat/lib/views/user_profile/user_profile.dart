import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../providers/user_provider.dart';
import 'package:provider/provider.dart';


class Profile extends StatefulWidget {
 
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  void initState() {
   
     Future.delayed(Duration.zero, () {
      Provider.of<UserProvider>(context, listen: false).fetchTheUser();
    });



    super.initState();
  }



  @override
  Widget build(BuildContext context) {
        final width = MediaQuery.of(context).size.width;
   return Scaffold(
        appBar: AppBar(
        
          backgroundColor: Colors.deepPurple,
          title: Text('Profile', style: TextStyle(color: Colors.white)),
        
        ),
        body: 
        
        Consumer<UserProvider>(
                builder: (context, model, child) {
                  Widget content = Center(
                      child: Text(
                          'Error fetching data. Check your Internet connection'));
          
                  if (model.isLoading) {
                    content = Center(child: CircularProgressIndicator());
                  } else if ((model.user.length == null && !model.isLoading)) {
                    content = Center(child: Text('Error loading user'));
                  } else if ((model.loggedUser != null && !model.isLoading)) {
                    content =   Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                    width: width / 1.2,
                   padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                            child: Center(
                          child: Icon(Icons.person, color: Colors.white, size: 40),
                        )),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.deepPurple, size: 26),
                            SizedBox(width: 8),
                            Text('Firstname: ${model.loggedUser.firstName}', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.deepPurple, size: 26),
                               SizedBox(width: 8),
                            Text('Lastname: ${model.loggedUser.lastName}', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.deepPurple, size: 26),
                               SizedBox(width: 8),
                            Text('Email:${model.loggedUser.email}', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                         SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.phone, color: Colors.deepPurple, size: 26),
                               SizedBox(width: 8),
                            Text('Phone: ${model.loggedUser.phone}', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.house, color: Colors.deepPurple, size: 26),
                               SizedBox(width: 8),
                            Text('Residence: ${model.loggedUser.residence}', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ],
                    )),
              ),
            ]);
                  }
          
                  return content;
                },
              ));
        
        
        
        
        
        
     
     
  }
}