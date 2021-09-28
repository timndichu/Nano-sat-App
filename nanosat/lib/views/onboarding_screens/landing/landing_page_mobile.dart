import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/views/onboarding_screens/auth/user_login.dart';
import 'package:nanosat/views/onboarding_screens/auth/user_signup.dart';
import 'package:nanosat/widgets/custom_path.dart';


import '../auth/user_login_mobile.dart';
import '../auth/user_signup_mobile.dart';


//THIS IS THE FIRST ONBOARDING SCREEN THE USER SEES ON OPENING THE APP
class WelcomePageMobile extends StatefulWidget {
  @override
  _WelcomePageMobileState createState() => _WelcomePageMobileState();
}

class _WelcomePageMobileState extends State<WelcomePageMobile> {
  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => LoginPage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 18, color: Colors.deepPurple),
          ),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => SignUpPage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _skipButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context, CupertinoPageRoute(builder: (context) => HomePage()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          child: Text(
            'Continue Anonymously',
            style: TextStyle(
                color: Colors.white,  fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.centerLeft,
            colors: [Colors.deepPurple, Colors.deepPurple[900]],
          ),
        ),
        child: Stack(
          children: [
           
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: LandingPageClipper2(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.7,
                    decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  // color: Color(0xffd4af37),
                                 color: Color(0x3f000000),
                                  blurRadius: 14,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                    child: ClipPath(
                        clipper: LandingPageClipper(),
                        child: Container(
                          color: Colors.black,
                            //  child: Image.network(
                            //     'https://content.latest-hairstyles.com/wp-content/uploads/burgundy-red-cornrows-on-long-hair-500x553.jpg',
                            //     fit: BoxFit.cover)
                            child: Image.asset(
                                'assets/images/earth.gif',
                                fit: BoxFit.contain)
                           )),
                  ),
                ),
                Center(
                  child: Container(
                    transform: Matrix4.translationValues(0.0, -60, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Text('Welcome to our Nano-Sat Info system',
                      textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 24, ))
                    ),
                  ),
                ),
             
                Center(
                  child: Container(
                      transform: Matrix4.translationValues(0.0, -20, 0.0),
                    child: CircleAvatar(radius: 60,  backgroundColor: Colors.deepPurple[200],  child:  Image.asset('assets/images/nanosat.png', height: 240, width: 240,),
            ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _loginButton(),
                      SizedBox(
                        height: 20,
                      ),
                      _registerButton(),
                      SizedBox(
                        height: 20,
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
            //  Positioned(top:40, left: 5, 
            // child: CircleAvatar(radius: 42,  backgroundColor: Colors.deepPurple,  child: Padding(
            //   padding: const EdgeInsets.only(left: 8.0),
            //   child: Image.asset('assets/washing-machine.png', height: 60, width: 60,),
            // )),
            // ),
          ],
        ),
      ),
    );
  }
}
