import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ft_app/bloc/login_bloc.dart';
import 'package:my_ft_app/bloc/login_event.dart';
import 'package:my_ft_app/data/LoginRequest.dart';
import 'package:my_ft_app/theme/color/MyColor.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginBloc = context.read<LoginBloc>();

    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: ListView(
            children: [
              const SizedBox(height: 72),
              Image.asset(
                "assets/images/ic_app.png",
                width: 110,
                height: 110,
              ),
              const SizedBox(height: 24),
              Flexible(
                child: MyOutLineTextField(
                  oulineSelectedColor: MyColors.primaryColor,
                  oulineUnselectedColor: MyColors.primaryColor,
                  hintText: "ID",
                ),
              ),
              const SizedBox(height: 24),
              Flexible(
                child: MyOutLineTextField(
                  oulineSelectedColor: MyColors.primaryColor,
                  oulineUnselectedColor: MyColors.primaryColor,
                  hintText: "비밀번호",
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: MyTextBtn(
                    text: "로그인",
                    onClick: () {
                      LoginRequest loginRequest = LoginRequest(
                          username: "engineer", password: "engineer@123");
                      _loginBloc.add(Login(loginRequest: loginRequest));
                    }),
              )
            ],
          ),
        ));
  }
}

class MyOutLineTextField extends StatelessWidget {
  final Color oulineSelectedColor;
  final Color oulineUnselectedColor;
  final String hintText;

  const MyOutLineTextField(
      {Key? key,
      required this.oulineSelectedColor,
      required this.oulineUnselectedColor,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: '',
      decoration: InputDecoration(
          labelText: hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.primaryColor50.shade100),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.primaryColor.shade100),
          ),
          labelStyle: TextStyle(color: MyColors.hintColor.shade100)),
    );
  }
}

class MyTextBtn extends StatelessWidget {
  final String text;
  final VoidCallback onClick;

  const MyTextBtn({Key? key, required this.text, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          primary: MyColors.primaryButtonColor,
          onPrimary: Colors.white,
          textStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      child: Text(text),
    );
  }
}
