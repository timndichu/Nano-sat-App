import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/providers/sensor_readings_provider.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class OpticalImaging extends StatefulWidget {
  @override
  _OpticalImagingState createState() => _OpticalImagingState();
}

class _OpticalImagingState extends State<OpticalImaging> {
  @override
  void initState() {
    Provider.of<SensorReadingsProvider>(context, listen: false)
                .opticalImages
                .length >
            0
        ? print('ALready fetched')
        : Future.delayed(Duration.zero, () {
            Provider.of<SensorReadingsProvider>(context, listen: false)
                .getOpticalImages();
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Consumer<SensorReadingsProvider>(
              builder: (context, model, child) {
            Widget content = Center(
                child: Text(
              'Error fetching data. Check your Internet connection',
              textAlign: TextAlign.center,
            ));

            if (model.isOpticalLoading) {
              content = Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Center(child: CircularProgressIndicator(color: Colors.deepPurple,)),
                ],
              );
            } else if ((model.opticalImages.length > 0 &&
                !model.isOpticalLoading)) {
              content = ListView.builder(
                  itemCount: model.opticalImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            width: width,
                            child: Column(children: [
                              Container(
                                width: width,
                                height: 200,
                                child: FadeInImage.memoryNetwork(
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    placeholder: kTransparentImage,
                                    image:
                                        model.opticalImages[index].imageUrl),
                              ),
                              SizedBox(height: 20),
                              Text('Optical Image taken on ${model.opticalImages[index].date}'),
                              SizedBox(height: 20),
                            ]),
                          )),
                    );
                  });
            } else if ((model.opticalImages.length == 0 &&
                !model.isOpticalLoading)) {
              content = Center(
                  child: Text(
                'No open Orders',
                textAlign: TextAlign.center,
              ));
            }

            return content;
          })),
    );
  }
}
