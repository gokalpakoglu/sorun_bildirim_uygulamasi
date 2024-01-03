import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/app.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/authentication/bloc/authentication_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
    create: (context) => AuthenticationBloc(),
    child: const MyApp(),
  ));
}
