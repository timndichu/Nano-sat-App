import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';



class ViewPic extends StatelessWidget {
  final String url;
  
  ViewPic({this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
        
          title: Text('View Picture', style: TextStyle(color: Theme.of(context).textTheme.headline1.color),),
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Container(
           
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child:PhotoView(
                backgroundDecoration: BoxDecoration(color: Theme.of(context).canvasColor),
                      imageProvider: NetworkImage(url)),
            ));
  }
}