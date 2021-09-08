import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../providers/user_provider.dart';
import '../views/home_page.dart';
import '../widgets/custom_path.dart';
import 'package:provider/provider.dart';

import '../../widgets/confirmformfield.dart';
import './user_login.dart';

import '../../widgets/password_formfield.dart';
import '../../widgets/text_input_decoration.dart';

//SIGN UP PAGE
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class NumberList {
  String option;
  int index;
  NumberList({this.option, this.index});
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  bool loading = false;
  String radioItemHolder = 'Through a Friend';

  // Group Value for Radio Button
  int id = 1;

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
  }

  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _area = TextEditingController();

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    _firstname.dispose();
    _lastname.dispose();
    _confirmpassword.dispose();
    _username.dispose();
    _phone.dispose();
    _area.dispose();
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
              'Already have an account ?',
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
                    CupertinoPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                'Login Here',
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
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: _focusNodes[0],
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1.color),
                  keyboardType: TextInputType.text,
                  controller: _firstname,
                  decoration: textInputDecoration.copyWith(
                    labelText: 'First Name',
                    fillColor: Theme.of(context).cardColor,
                    labelStyle: TextStyle(
                        color: _focusNodes[0].hasFocus
                            ? Theme.of(context).accentColor
                            : Colors.grey),
                    hintStyle: TextStyle(
                        color: _focusNodes[0].hasFocus
                            ? Theme.of(context).accentColor
                            : Colors.grey),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter firstname' : null,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  focusNode: _focusNodes[1],
                  style: TextStyle(
                      color: Theme.of(context).textTheme.headline1.color),
                  keyboardType: TextInputType.text,
                  controller: _lastname,
                  decoration: textInputDecoration.copyWith(
                    labelText: 'Last Name',
                    fillColor: Theme.of(context).cardColor,
                    labelStyle: TextStyle(
                        color: _focusNodes[1].hasFocus
                            ? Theme.of(context).accentColor
                            : Colors.grey),
                    hintStyle: TextStyle(
                        color: _focusNodes[1].hasFocus
                            ? Theme.of(context).accentColor
                            : Colors.grey),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter lastname' : null,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextFormField(
            focusNode: _focusNodes[3],
            style:
                TextStyle(color: Theme.of(context).textTheme.headline1.color),
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            decoration: textInputDecoration.copyWith(
              labelText: 'Email',
              fillColor: Theme.of(context).cardColor,
              labelStyle: TextStyle(
                  color: _focusNodes[3].hasFocus
                      ? Theme.of(context).accentColor
                      : Colors.grey),
              hintStyle: TextStyle(
                  color: _focusNodes[3].hasFocus
                      ? Theme.of(context).accentColor
                      : Colors.grey),
              prefixIcon: Icon(
                Icons.email,
                color: _focusNodes[3].hasFocus
                    ? Theme.of(context).accentColor
                    : Colors.grey,
              ),
            ),
            validator: (val) => val.isEmpty ? 'Enter an email' : null,
          ),
          SizedBox(height: 20.0),
          TextFormField(
            focusNode: _focusNodes[4],
            style:
                TextStyle(color: Theme.of(context).textTheme.headline1.color),
            keyboardType: TextInputType.phone,
            controller: _phone,
            decoration: textInputDecoration.copyWith(
              labelText: 'Phone Number',
              fillColor: Theme.of(context).cardColor,
              labelStyle: TextStyle(
                  color: _focusNodes[4].hasFocus
                      ? Theme.of(context).accentColor
                      : Colors.grey),
              hintStyle: TextStyle(
                  color: _focusNodes[4].hasFocus
                      ? Theme.of(context).accentColor
                      : Colors.grey),
              prefixIcon: Icon(
                Icons.phone_android,
                color: _focusNodes[4].hasFocus
                    ? Theme.of(context).accentColor
                    : Colors.grey,
              ),
            ),
            validator: (val) => val.isEmpty ? 'Enter phone number' : null,
          ),
          SizedBox(height: 20.0),
          TextFormField(
            focusNode: _focusNodes[5],
            style:
                TextStyle(color: Theme.of(context).textTheme.headline1.color),
            keyboardType: TextInputType.text,
            controller: _area,
            decoration: textInputDecoration.copyWith(
              labelText: 'Area of Residence',
              fillColor: Theme.of(context).cardColor,
              labelStyle: TextStyle(
                  color: _focusNodes[5].hasFocus
                      ? Theme.of(context).accentColor
                      : Colors.grey),
              hintStyle: TextStyle(
                  color: _focusNodes[5].hasFocus
                      ? Theme.of(context).accentColor
                      : Colors.grey),
              prefixIcon: Icon(
                Icons.house_rounded,
                color: _focusNodes[5].hasFocus
                    ? Theme.of(context).accentColor
                    : Colors.grey,
              ),
            ),
            validator: (val) => val.isEmpty ? 'Enter area of residence' : null,
          ),
          SizedBox(height: 20.0),
          PasswordFormField(controller: _password, focusNode: _focusNodes[6]),
          SizedBox(height: 20.0),
          ConfirmFormField(
              controller: _confirmpassword,
              password: _password,
              focusNode: _focusNodes[7]),
          SizedBox(height: 20.0),
          _termsOfService(),
          SizedBox(height: 20.0),
          loading ? Center(child: CircularProgressIndicator()) : _submitButton(),
          SizedBox(height: 10.0),
          _divider(),
          _createAccountLabel(),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }

  Widget _termsOfService() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'By clicking Sign Up, you agree to our',
          style: TextStyle(
              fontFamily: 'InterRegular', fontSize: 14, color: Colors.grey),
          children: [
            TextSpan(
              text: ' Terms of Service',
              style: TextStyle(
                  color: Colors.blue, fontFamily: 'InterRegular', fontSize: 14),
            ),
            TextSpan(
              text: ' and that you have read our',
              style: TextStyle(
                  color: Colors.grey, fontFamily: 'InterRegular', fontSize: 14),
            ),
            TextSpan(
              text: ' Privacy Policy',
              style: TextStyle(
                  color: Colors.blue, fontFamily: 'InterRegular', fontSize: 14),
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

  Widget _submitButton() {
    return InkWell(
        onTap: () {
       
          if (_formKey.currentState.validate()) {
            Map<String, String> data = {
              "firstname": _firstname.text,
              "lastname": _lastname.text,
              "email": _email.text,
              "password": _password.text,
              "residence": _area.text,
              "phone": _phone.text
            };
               setState(() {
            loading = true;
          });       
            print(data);
            Provider.of<UserProvider>(context, listen: false)
                .postSignUp("/laundry/auth/user-signup", data)
                .then((response)  {
                      if (response['success'])
                        {
                              Provider.of<UserProvider>(context, listen: false).setEmail(data['email']);
                          setState(() {
                            loading = false;
                          });
                          print('succees');
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
                      content:
                          Text('Check your Internet connection then try again'),
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
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.deepPurple,
                    Colors.deepPurple[900],
                  ]),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white),
          child: Text(
            'Sign Up',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
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
        child: NestedScrollView(
          // allows you to build a list of elements that would be scrolled away till the body reached the top
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([
                  Stack(children: <Widget>[
                    WaveDesign(),
                    Positioned(top: 40, left: 0, child: _backButton()),
                  ])
                ]),
              ),
            ];
          },
          //Tab view goes here
          body: Container(
              height: height,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: _formWidget(),
              )),
        ),
      ),
    );
  }
}

class WaveDesign extends StatelessWidget {
  const WaveDesign({
    Key key,
  }) : super(key: key);
  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Sign',
          style: TextStyle(
              fontFamily: 'InterRegular',
              fontSize: 30,
              color: Colors.amber[800]),
          children: [
            TextSpan(
              text: ' Up',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'InterRegular',
                  fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.6,
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
            child: Center(
              child: _title(),
            ),
          )),
    );
  }
}
