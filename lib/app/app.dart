import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/authentication/bloc/view/authentication_view.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/view/register_view.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.dart';

class MyApp extends StatelessWidget {
  //final _appRouter = AppRouter();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // routerConfig: _appRouter.config(),
      // routerDelegate: _appRouter.delegate(),
      // routeInformationParser: _appRouter.defaultRouteParser(),
      home: RegisterView()
    );
  }
}
