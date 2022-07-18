import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ft_app/UI/LoginScreen.dart';
import 'package:my_ft_app/bloc/form_validation/form_validation_bloc.dart';
import 'package:my_ft_app/bloc/login/login_bloc.dart';
import 'package:my_ft_app/bloc/login/login_event.dart';
import 'package:my_ft_app/bloc/wage/get_wage_bloc.dart';
import 'package:my_ft_app/network/ApiProvider.dart';
import 'package:my_ft_app/network/Login/LoginRepository.dart';
import 'package:my_ft_app/network/Wage/WageRepository.dart';
import 'package:my_ft_app/theme/color/MyColor.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, // optional
    ));
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiProvider>(create: (context) => ApiProvider()),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<LoginRepository>(
              create: (context) =>
                  LoginRepository(context.read<ApiProvider>())),
          RepositoryProvider<WageRepository>(
              create: (context) => WageRepository(context.read<ApiProvider>())),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<LoginBloc>(
                  create: (context) => LoginBloc(
                        loginRepository: context.read<LoginRepository>(),
                      )),
              BlocProvider<FormValidationBloc>(
                  create: (context) => FormValidationBloc()),
              BlocProvider<GetWageBloc>(
                  create: (context) => GetWageBloc(
                        wageRepository: context.read<WageRepository>(),
                      )),
            ],
            child: MaterialApp(
              title: "MyApp",
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  primarySwatch: MyColors.primaryColor,
                  fontFamily: 'NotoSan'),
              home:  LoginScreen(),
            )),
      ),
    );
  }
}
