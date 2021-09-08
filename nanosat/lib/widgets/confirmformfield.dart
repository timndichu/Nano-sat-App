import 'package:flutter/material.dart';


import 'text_input_decoration.dart';

class ConfirmFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController password;
    final FocusNode focusNode;

  const ConfirmFormField({
    this.password,
    Key key,
     @required this.focusNode,
    @required this.controller,
  })  : assert(controller != null, focusNode !=null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfirmFormFieldState();
}

class _ConfirmFormFieldState extends State<ConfirmFormField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
         style: TextStyle(   color: Theme.of(context).textTheme.headline1.color),
      controller: widget.controller,
     decoration: textInputDecoration.copyWith(
          fillColor: Theme.of(context).cardColor,
                labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: widget.focusNode.hasFocus ? Theme.of(context).accentColor : Colors.grey),
               hintStyle: TextStyle(color: widget.focusNode.hasFocus ? Theme.of(context).accentColor : Colors.grey),
              prefixIcon: Icon(Icons.lock,  color: widget.focusNode.hasFocus ? Theme.of(context).accentColor : Colors.grey,),
                
              
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  child: Icon(
                   _showPassword ? Icons.visibility : Icons.visibility_off ,    color: widget.focusNode.hasFocus ? Theme.of(context).accentColor : Colors.grey,
                 
                  ),
                ),
              ),
      obscureText: !_showPassword,
      validator: (val) => val != widget.password.text ? 'Passwords dont match' : null,
    );
  }
}