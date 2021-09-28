import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(


     appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
            headline5: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'InterRegular'),
            headline6: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'InterRegular')),
      ),

      unselectedWidgetColor: Colors.deepPurple[300],
      primaryColor: AppColors.primaryDark,
         bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepPurple,
          
          selectedIconTheme: IconThemeData(color: Colors.deepPurple)),
      textTheme: TextTheme(
        
          bodyText2: TextStyle(
              color: Colors.white, fontFamily: 'InterRegular', fontSize: 16),
          bodyText1: TextStyle(
              color: Colors.white, fontFamily: 'InterRegular', fontSize: 16),
          headline1: TextStyle(
            color: Colors.white,
            fontFamily: 'InterRegular',
          ),
          headline5: TextStyle(
            color: Colors.white,
            fontFamily: 'InterRegular',
          ),
          headline6: TextStyle(
            color: Colors.white,
            fontFamily: 'InterRegular',
          )),
    
  
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: AppColors.textGrey,
          fontFamily: 'InterRegular',
        ),
        labelStyle: TextStyle(
          color: AppColors.white,
          fontFamily: 'InterRegular',
        ),
      ),
    
      brightness: Brightness.dark,
      canvasColor: AppColors.lightGreyDarkMode,
      // accentColor: AppColors.darkPink,
      accentColor: Colors.deepPurple,
      accentIconTheme: IconThemeData(color: Colors.white),
      cardColor: AppColors.primaryDark,
      dividerColor: Colors.deepPurple,
      toggleableActiveColor: Colors.deepPurple,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.deepPurple),
      iconTheme: IconThemeData(
        color: Colors.deepPurple[300],
      ),

      
      
      bottomAppBarColor: AppColors.darkThemeBottomColor3,
      bottomAppBarTheme: BottomAppBarTheme(
        color: AppColors.darkThemeBottomColor3,
      ));

  static final ThemeData lightTheme = ThemeData(

      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
            headline5: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'InterRegular'),
            headline6: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'InterRegular')),
      ),
       focusColor: Colors.deepPurple,

     
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepPurple,
          selectedIconTheme: IconThemeData(color: Colors.deepPurple)),
      textTheme: TextTheme(
        bodyText1: TextStyle(
            color: Colors.black, fontFamily: 'InterRegular', fontSize: 16),
        bodyText2: TextStyle(
            color: Colors.black, fontFamily: 'InterRegular', fontSize: 16),
        headline1: TextStyle(
          color: Colors.black,
          fontFamily: 'InterRegular',
        ),
      ),
//           iconTheme: IconThemeData(color: Colors.deepPurple),
//           primaryIconTheme: IconThemeData(color: Colors.deepPurple),
      accentColor: Colors.deepPurple,
      primaryColor: Colors.deepPurple,

//       toggleableActiveColor: Colors.deepPurple,
      inputDecorationTheme: InputDecorationTheme(
        
        hintStyle: TextStyle(
          fontFamily: 'InterRegular',
       
        ),
        labelStyle: TextStyle(
          fontFamily: 'InterRegular',
      
        ),
      ),
      canvasColor: Color(0xfff6f5f5),
      brightness: Brightness.light,

      //Colors for Category Card
      cardColor: Colors.white,
      dividerColor: Colors.grey[300],
      bottomAppBarTheme: BottomAppBarTheme(color: Colors.white));
}
