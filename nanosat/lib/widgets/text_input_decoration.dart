import 'package:flutter/material.dart';

const textInputDecoration =  InputDecoration(
                    labelStyle: TextStyle(color:  Colors.grey),
                      hintStyle: TextStyle(color: Colors.deepPurple),
                    focusColor: Colors.deepPurple ,
                    fillColor: Colors.white,
                    filled: true,
              
                    enabledBorder: OutlineInputBorder(
                  
                      borderSide: BorderSide(
                        
                        color: Colors.grey, width: 0.5, ),
                    ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                    ),
                  );

