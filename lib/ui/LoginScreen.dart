import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ft_app/bloc/form_validation/form_validation_bloc.dart';
import 'package:my_ft_app/bloc/login/login_bloc.dart';
import 'package:my_ft_app/bloc/wage/get_wage_bloc.dart';
import 'package:my_ft_app/theme/color/MyColor.dart';
import 'package:my_ft_app/ui/HomeScreen.dart';

import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../data/Login/LoginRequest.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginBloc = context.read<LoginBloc>();
    final wageBloc = context.read<GetWageBloc>();
    final formValidationBloc = context.read<FormValidationBloc>();

    String userName = "";
    String passWord = "";

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: BlocConsumer<FormValidationBloc, FormValidationState>(
              listener:  (context, formValidationState) {
                print("Henry ${formValidationState.runtimeType}");
                if (formValidationState is FormCorrect) {
                  print("Henry -> Form is correct");
                  formValidationBloc.emit(FormValidationInitial());
                  loginBloc.add(Login(
                      loginRequest: LoginRequest(
                          username: userName, password: passWord)));
                }
              },
              builder: (context, formValidationState) {

                return BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, loginState){
                    if(loginState is LoginSuccess){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  HomeScreen()),
                      );
                    }
                  },
                  builder: (context, loginState) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        ListView(
                          children: [
                            const SizedBox(height: 72),
                            Image.asset(
                              "assets/images/ic_app.png",
                              width: 110,
                              height: 110,
                            ),
                            const SizedBox(height: 24),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                    MyOutLineTextField(
                                      oulineSelectedColor:
                                          MyColors.primaryColor,
                                      oulineUnselectedColor:
                                          MyColors.primaryColor,
                                      hintText: "ID",
                                      onTextChange: (text) {
                                        userName = text;
                                      },
                                      errorText:
                                          (formValidationState is UserNameEmpty)
                                              ? "Username is empty"
                                              : null,
                                      isPasswordTextFeild: false,
                                    ),
                                    const SizedBox(height: 24),
                                    MyOutLineTextField(
                                      // UserName
                                      oulineSelectedColor:
                                          MyColors.primaryColor,
                                      oulineUnselectedColor:
                                          MyColors.primaryColor,
                                      hintText: "비밀번호",
                                      onTextChange: (text) {
                                        passWord = text;
                                      },
                                      errorText:
                                          (formValidationState is PasswordEmpty)
                                              ? "Password is empty"
                                              : null,
                                      isPasswordTextFeild: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: MyTextBtn(
                                  text: "로그인",
                                  onClick: () {
                                    LoginRequest loginRequest = LoginRequest(
                                        username: userName, password: passWord);
                                    formValidationBloc.add(
                                        FormScreenEventSubmit(
                                            loginRequest: loginRequest));
                                    if (loginState is LoginSuccess) {
                                      // navigate to home screen
                                    }
                                  }),
                            )
                          ],
                        ),
                        (loginState is LoginLoading)
                            ? const CircularProgressIndicator()
                            : (loginState is LoginFail)
                                ? MyDialog(
                                    title: "Something went wrong",
                                    content: (loginState.errorMess != null)
                                        ? loginState.errorMess!
                                        : "Something when wrong",
                                    context: context,
                                    onConfirmClick: () {
                                      loginBloc.emit(LoginInitial());
                                    },
                                  )
                                : Container(),
                      ],
                    );
                  },
                );
              },
            )));
  }
}

class MyOutLineTextField extends StatefulWidget {
  final Color oulineSelectedColor;
  final Color oulineUnselectedColor;
  final String hintText;
  final String? errorText;
  final Function(String) onTextChange;
  final bool isPasswordTextFeild;

  const MyOutLineTextField(
      {Key? key,
      required this.oulineSelectedColor,
      required this.oulineUnselectedColor,
      required this.hintText,
      required this.onTextChange,
      required this.isPasswordTextFeild,
      this.errorText})
      : super(key: key);

  @override
  State<MyOutLineTextField> createState() => _MyOutLineTextFieldState();
}

class _MyOutLineTextFieldState extends State<MyOutLineTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: widget.onTextChange,
        initialValue: '',
        obscureText: widget.isPasswordTextFeild,
        decoration: InputDecoration(
            labelText: widget.hintText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.primaryColor50.shade100),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.errorColor.shade100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.primaryColor.shade100),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyColors.errorColor.shade100),
            ),
            labelStyle: TextStyle(color: MyColors.hintColor.shade100),
            errorText: (widget.errorText != null) ? widget.errorText : null));
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

class MyDialog extends StatefulWidget {
  final String title, content;
  final BuildContext context;
  final VoidCallback onConfirmClick;

  const MyDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.context,
      required this.onConfirmClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyDialogState();
  }
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: widget.onConfirmClick,
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
