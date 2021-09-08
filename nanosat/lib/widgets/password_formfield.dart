import 'package:flutter/material.dart';

import 'text_input_decoration.dart';

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const PasswordFormField({
    Key key,
    @required this.controller,
    @required this.focusNode,
  })  : assert(controller != null, focusNode !=null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
       style: TextStyle(   color: Theme.of(context).textTheme.headline1.color),
      controller: widget.controller,
     decoration: textInputDecoration.copyWith(
                fillColor: Theme.of(context).cardColor,
                labelText: 'Password',
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
      validator: (val) => val.length < 6 ? 'Enter a password 6+ characters Long' : null,
    );
  }
}