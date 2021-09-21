import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nanosat/providers/user_provider.dart';

import 'package:nanosat/views/main_tabs/homepage/homepage.dart';
import 'package:nanosat/widgets/custom_path.dart';

import 'package:provider/provider.dart';


import '../../../widgets/password_formfield.dart';
import '../../../widgets/text_input_decoration.dart';

import 'user_signup_mobile.dart';

//LOGIN PAGE
class LoginPageDesktop extends StatefulWidget {
  @override
  _LoginPageDesktopState createState() => _LoginPageDesktopState();
}

class _LoginPageDesktopState extends State<LoginPageDesktop> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool loading = false;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    _focusNodes.forEach((node) {
      node.dispose();
    });
    super.dispose();
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: Colors.grey[400],
              ),
            ),
          ),
          Text('or',
              style: TextStyle(
                  color: Theme.of(context).textTheme.headline1.color)),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
                color: Colors.grey[400],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //     context, CupertinoPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).textTheme.headline1.color),
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => SignUpPage()));
              },
              child: Text(
                'Sign Up Here',
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _formWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            focusNode: _focusNodes[0],
            style:
                TextStyle(color: Theme.of(context).textTheme.headline1.color),
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            decoration: textInputDecoration.copyWith(
              labelText: 'Email',
              fillColor: Theme.of(context).cardColor,
              labelStyle: TextStyle(
                  color: _focusNodes[0].hasFocus
                      ? Theme.of(context).accentColor
                      : Colors.grey),
              hintStyle: TextStyle(
                  color: _focusNodes[0].hasFocus
                      ? Theme.of(context).accentColor
                      : Colors.grey),
              prefixIcon: Icon(
                Icons.email,
                color: _focusNodes[0].hasFocus
                    ? Theme.of(context).accentColor
                    : Colors.grey,
              ),
            ),
            validator: (val) => val.isEmpty ? 'Enter email' : null,
          ),
          SizedBox(height: 20.0),
          PasswordFormField(
            focusNode: _focusNodes[1],
            controller: _password,
          ),
          SizedBox(height: 30.0),
          loading ? CircularProgressIndicator( color:  Colors.deepPurple) : _userSubmitButton(),
          SizedBox(height: 20.0),

          // GestureDetector(
          //   onTap: () {
          //     // Navigator.push(
          //     //     context,
          //     //     CupertinoPageRoute(
          //     //         builder: (context) => ResetPassword()));
          //   },
          //   child: Container(
          //     padding: EdgeInsets.symmetric(vertical: 10),
          //     alignment: Alignment.center,
          //     child: Text('Forgot Password ?',
          //         style: TextStyle(
          //             fontSize: 14,
          //             fontWeight: FontWeight.w500,
          //                color: Theme.of(context).textTheme.headline1.color)),
          //   ),
          // ),
          _divider(),
          _createAccountLabel(),
        ],
      ),
    );
  }

  Widget _userSubmitButton() {
    return InkWell(
        onTap: () {
        
          if (_formKey.currentState.validate()) {
            Map<String, String> data = {
              "email": _email.text,
              "password": _password.text
            };
              setState(() {
            loading = true;
          });
            print(data);
            Provider.of<UserProvider>(context, listen: false)
                .postLogin("/laundry/auth/user-login", data)
                .then((response)  {
                  print('the response is $response');
                      if (response['success'])
                        {
                             Provider.of<UserProvider>(context, listen: false).setEmail(data['email']);
                         
                          print('success');
                          Navigator.pushAndRemoveUntil(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Homepage()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      else
                        {
                          setState(() {
                            loading = false;
                          });
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(response['message']),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'))
                                  ],
                                );
                              });
                        }
                    })
                .catchError((error) {
              setState(() {
                loading = false;
              });
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                          'An Error occurred.\nCheck your Internet connection then try again'),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'))
                      ],
                    );
                  });
            });
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.deepPurple, Colors.deepPurple[700]]),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Welcome',
          style: TextStyle(
              fontFamily: 'InterRegular',
              fontSize: 30,
              color: Colors.amber[800]),
          children: [
            TextSpan(
              text: ' Back',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'InterRegular',
                  fontSize: 30),
            ),
          ]),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
                size: 30,
              ),
            ),
            Text('Back',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -height * .15,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.6,
                    child: ClipPath(
                        clipper: LandingPageClipper(),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.deepPurple,
                                Colors.deepPurple[900],
                              ])),
                        )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: height * .15),
                        _title(),
                        SizedBox(height: height * .25),
                        _formWidget(),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 40, left: 0, child: _backButton()),
              ],
            ),
          ),
        ));
  }
}
