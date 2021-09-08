import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';


import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductsCard extends StatefulWidget {
  final String url;
  final String title;
  final int index;
  final num price;
  final Product product;
  ProductsCard({this.url, this.product, this.price, this.title, this.index});

  @override
  _ProductsCardState createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                offset: Offset(1, 2),
                blurRadius: 8,
                spreadRadius: 1)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    placeholder: kTransparentImage,
                    image: widget.product.image),
              ),
            ),
               SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal :8.0),
                  child: Container(
                    height: 25,
                    child: widget.product.title == null ||
                            widget.product.title.length == 0
                        ? Text('Air Max', style: TextStyle(fontSize: 16.5))
                        : Text(widget.product.title,
                            style: TextStyle(fontSize: 16.5)),
                  ),
                ),
             
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal :8.0),
                  child: Container(
                    height: 25,
                    child: widget.product.price == null
                        ? Text('Ksh.1',
                            style: TextStyle(
                                fontSize: 16.5, fontWeight: FontWeight.bold))
                        : Text('Ksh. ${widget.product.price}',
                            style: TextStyle(
                                fontSize: 16.5, fontWeight: FontWeight.bold)),
              
        
            ),
                ),
           
           
          ],
        ),
      ),
    );
  }
}
