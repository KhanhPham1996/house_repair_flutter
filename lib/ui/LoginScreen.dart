import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ft_app/bloc/form_validation/form_validation_bloc.dart';
import 'package:my_ft_app/bloc/login/login_bloc.dart';
import 'package:my_ft_app/bloc/login/login_event.dart';
import 'package:my_ft_app/bloc/login/login_state.dart';
import 'package:my_ft_app/bloc/wage/get_wage_bloc.dart';
import '../../data/Login/LoginRequest.dart';
import 'package:my_ft_app/theme/color/MyColor.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final _loginBloc = context.read<LoginBloc>();
    final _wageBloc = context.read<GetWageBloc>();
    final _formValidationBloc = context.read<FormValidationBloc>();

    String userName = "";
    String passWord = "";
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: BlocBuilder<FormValidationBloc, FormValidationState>(
          builder: (context, formValidationState) {
            print("Henry ${formValidationState.runtimeType}");
            if (formValidationState is FormCorrect) {
              print("Henry -> Form is correct");
              _formValidationBloc.emit(FormValidationInitial());
              _loginBloc.add(Login(
                  loginRequest: LoginRequest(
                      username: userName, password: passWord)));
            }
            return BlocBuilder <LoginBloc, LoginState>(
              builder: (context, loginState) {
                return ListView(

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
                              oulineSelectedColor: MyColors.primaryColor,
                              oulineUnselectedColor: MyColors.primaryColor,
                              hintText: "ID",
                              onTextChange: (text) {
                                userName = text;
                              },
                              errorText: (formValidationState is UserNameEmpty)
                                  ? "Username is empty"
                                  : null,
                              isPasswordTextFeild: false,
                            ),
                            const SizedBox(height: 24),
                            MyOutLineTextField(
                              // UserName
                              oulineSelectedColor: MyColors.primaryColor,
                              oulineUnselectedColor: MyColors.primaryColor,
                              hintText: "비밀번호",
                              onTextChange: (text) {
                                passWord = text;
                              },
                              errorText: (formValidationState is PasswordEmpty)
                                  ? "Password is empty"
                                  : null,
                              isPasswordTextFeild: true,
                            ),

                          ],
                        ),

                        (loginState is LoginLoading)
                            ? const CircularProgressIndicator()
                            :  (loginState is LoginFail)
                            ? const showAlertDialog()
                            :  (loginState is LoginSuccess)
                            ? const Text("Login Success")
                            : Container(),
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
                            _formValidationBloc.add(FormScreenEventSubmit(
                                loginRequest: loginRequest));
                            if(loginState is LoginSuccess){
                              _wageBloc.add(GetWage());
                            }
                          }),
                    )
                  ],
                );
              },
            );
          },
        ));
  }
}

class MyOutLineTextField extends StatefulWidget {
  final Color oulineSelectedColor;
  final Color oulineUnselectedColor;
  final String hintText;
  final String? errorText;
  final Function(String) onTextChange;
  final bool isPasswordTextFeild;

  const MyOutLineTextField({Key? key,
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
  @override
  State<StatefulWidget> createState() {
    return _MyDialogState();
  }
}

class _MyDialogState  extends  State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

    );
  }
}
