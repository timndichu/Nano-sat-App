import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../providers/shop_provider.dart';
import '../widgets/productsCard.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
 final int serviceId;
  Products({this.serviceId});

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  bool isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
            Provider.of<ShopProvider>(context, listen: false)
                .getProducts(widget.serviceId);
          });

    super.initState();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration.zero, () {
      Provider.of<ShopProvider>(context, listen: false)
          .getProducts(widget.serviceId)
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
        
          backgroundColor: Colors.deepPurple,
          title: Text('Products', style: TextStyle(color: Colors.white)),
        
        ),
        body: Container(
          height: height,
          padding: EdgeInsets.all(16),
          child: Column(children: <Widget>[
              Expanded(child: Consumer<ShopProvider>(
                builder: (context, model, child) {
                  Widget content = Center(
                      child: Text(
                          'Error fetching data. Check your Internet connection'));
          
                  if (model.isLoading) {
                    content = Center(child: CircularProgressIndicator());
                  } else if ((model.products.length == 0 && !model.isLoading)) {
                    content = Center(child: Text('No products added yet'));
                  } else if ((model.products.length > 0 && !model.isLoading)) {
                    content = new RefreshIndicator(
                      onRefresh: _refresh,
                      child: GridView.builder(
                        padding: EdgeInsets.all(8),
                        physics: AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.75),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: model.products.length,
                       itemBuilder: (BuildContext _context, int index) {
                          if (index < model.products.length) {
                            return ProductsCard(
                                product: model.products[index],
                               
                                index: model.products[index].id);
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 32.0),
                              child: Center(child: Text('nothing more to load!')),
                            );
                          }
                        },
                      ),
                    );
                  }
          
                  return content;
                },
              ))
            ])));
       
   
  }
}


