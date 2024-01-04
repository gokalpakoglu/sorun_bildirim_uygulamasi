import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.dart';

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    );
  }
}
