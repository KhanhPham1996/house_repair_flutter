import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ft_app/UI/LoginScreen.dart';
import 'package:my_ft_app/bloc/login_bloc.dart';
import 'package:my_ft_app/network/Login/LoginRepository.dart';
import 'package:my_ft_app/theme/color/MyColor.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent, // optional
    ));
    return RepositoryProvider(
      create: (context) => LoginRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              loginRepository: context.read<LoginRepository>(),
            )
          ),
        ],
        child:   MaterialApp(
          title: "MyApp",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: MyColors.primaryColor,
              fontFamily: 'NotoSan'
          ),
          home: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              toolbarHeight: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.light,
              ),
            ),
            body: LoginScreen(),

          ),
        )
      ),
    );


  }
}
