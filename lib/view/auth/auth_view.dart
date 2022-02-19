import 'package:flutter/material.dart';
import 'package:onboarding_app/core/components/passwordInput.dart';
import 'package:onboarding_app/view/auth/auth_const.dart';
import 'package:onboarding_app/view/constants.dart';
import 'package:kartal/kartal.dart';

import '../../core/components/text_input.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isRegister = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _againController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _againFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Spacer(
            flex: 20,
          ),
          Expanded(flex: 3, child: _buildWelcomeText()),
          Expanded(flex: 9, child: _buildTitle()),
          const Spacer(
            flex: 5,
          ),
          Expanded(flex: (_isRegister)? 31 :25, child: _buildFields()),
          Expanded(flex: 13, child: _buildLoginButton()),
          Spacer(
            flex: (_isRegister)? 9 : 13,
          ),
          Expanded(flex: 5, child: _buildSwitcher()),
          Spacer(
            flex: (_isRegister)? 5 : 7,
          )
        ],
      ),
    ));
  }

  Widget _buildSwitcher(){
    return InkWell(
      onTap: switchRegisterLogin,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text((_isRegister)? convertToLogin : convertToRegister),
          const SizedBox(width: 5,),
          Text((_isRegister)? convertToLoginButton : convertToRegisterButton , style: const TextStyle(
            color: Colors.black,fontWeight: FontWeight.bold
          ), )
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: buttonOnTap,
        child: Container(
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(32)
          ),
          child: Center(
            child: FittedBox(
              child: Text((_isRegister)? registerButton : loginButton, style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 2
              ),),
            ),
          ),
        ),
      ),
    );
  } 

  Widget _buildWelcomeText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: FittedBox(
        child: Text(
          welcome,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: Alignment.centerLeft,
      child: FittedBox(
        child: Text(
          authTitle,
          style: Theme.of(context)
              .textTheme
              .headline2
              ?.copyWith(color: Colors.black, fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _buildFields() {
    return Column(
      children: [
        Expanded(
          child: SizedBox(
              child: TextInputSimple(
            controller: _emailController,
            focusNode: _emailFocus,
            hintText: emailHint,
          )),
        ),
        Expanded(
            child: PasswordInput(
          controller: _passwordController,
          focusNode: _passwordFocus,
          hintText: passwordHint,
        )),
        (_isRegister) ? Expanded(
          child: PasswordInput(
            controller: _againController,
            focusNode: _againFocus,
            hintText: "Password Again",
          ),
        ) : const SizedBox(),
        (_isRegister) ? const SizedBox() : _buildForgotPassword()
      ],
    );
  }

  Align _buildForgotPassword() => Align(
      alignment: Alignment.topRight,
      child: InkWell(
          child: Text(
        forgotPassword,
        style: const TextStyle(color: Colors.grey),
      )));

  buttonOnTap(){

  }

  switchRegisterLogin(){
    setState(() {
      _isRegister = !_isRegister;
    });
  }

  forgotPasswordFunc(){
    Navigator.pushNamed(context, "/forgotPassword");
  }
}
