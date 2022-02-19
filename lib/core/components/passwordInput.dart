import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kartal/kartal.dart';
import 'package:onboarding_app/view/constants.dart';


// ignore: must_be_immutable
class PasswordInput extends StatefulWidget {
  Function? onChange;
  bool? readOnly;
  Function? onTap;
  bool? secure;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyBoardType;
  TextInputAction? textInputAction;
  Function? func;
  late FocusNode focusNode;
  String? errorText;
  String? hintText;
  late TextEditingController controller;
  Icon? prefixIcon;
  Icon? suffixIcon;
  Function? suffixFunc;
  PasswordInput(
      {Key? key,
      Function? onChange,
      bool? readOnly,
      bool? secure,
      required TextEditingController controller,
      List<TextInputFormatter>? inputFormatters,
      Icon? prefixIcon,
      String? errorText,
      required FocusNode focusNode,
      Function? onTap,
      Function? func,
      TextInputAction? textInputAction,
      String? hintText,
      Icon? suffixIcon,
      Function? suffixFunc,
      TextInputType? keyBoardType})
      : super(key: key) {
        this.onChange =onChange;
    this.readOnly = readOnly;
    this.controller = controller;
    this.prefixIcon = prefixIcon;
    this.errorText = errorText;
    this.focusNode = focusNode;
    this.func = func;
    this.textInputAction = textInputAction;
    this.hintText = hintText;
    this.suffixIcon = suffixIcon;
    this.suffixFunc = suffixFunc;
    this.keyBoardType = keyBoardType;
    this.inputFormatters = inputFormatters;
    this.secure = secure;
    this.onTap =onTap;
  }

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  var _secure = true;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (widget.focusNode.hasFocus) {
      setState(() {
        _focused = true;
      });
    } else {
      setState(() {
        _focused = false;
      });
    }
  }

  var _focused = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  context.dynamicWidth(343/375),
      height: context.dynamicHeight(80/812),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: context.dynamicWidth(343/375),
                height: context.dynamicHeight(64/812),
                decoration: BoxDecoration(
                border: _focused
                    ? Border.all(color: mainColor)
                    : Border.all(color: Colors.grey),
                //boxShadow: [BoxShadow(color: Color(0x33000000),blurRadius: 10,offset: Offset(0, 4),),],
                borderRadius: BorderRadius.circular(8),
                color: Colors.white),
                padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
        ),
              ),
              Text(
                widget.errorText ?? "",
                style: const TextStyle(
                  color: Colors.red
              ), 
              )
            ],
          ),
          _buildObx()
        ],
      ),
    );
  }

  Widget _buildObx() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      
      
      child: TextFormField(
        onTap: (){
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        onChanged: (val){
          if(widget.onChange!=null){
            widget.onChange!();
          }
        },
        keyboardType: widget.keyBoardType,
        readOnly: widget.readOnly ?? false,
        inputFormatters: widget.inputFormatters,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        focusNode: widget.focusNode,
        onFieldSubmitted: (term) {
          if (widget.func != null) {
            widget.func!();
          }
        },
        obscureText: _secure,
        controller: widget.controller,
        decoration: InputDecoration(
            hintText: widget.hintText,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusColor: mainColor,
            prefixIcon: widget.prefixIcon,
            suffixIcon: _buildSuffix(),
            ),
      ),
    );
  }

  _buildSuffix() {
    return IconButton(
      icon: _secure ? const Icon(CupertinoIcons.eye_slash_fill,color: mainColor,) : const Icon(CupertinoIcons.eye_fill,color: mainColor,), 
      onPressed: (){
        setState(() {
          _secure = !_secure;
        });
      }
      );
}
}