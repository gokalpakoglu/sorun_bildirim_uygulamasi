import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:sorun_bildirim_uygulamasi/app/app.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/app_settings/bloc/app_settings_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/bloc/home_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/login/bloc/login_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/profile/bloc/profile_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/bloc/register_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FlutterConfig.loadEnvVariables();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<RegisterBloc>(create: (context) => RegisterBloc()),
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc(),
      ),
      BlocProvider<AppSettingsBloc>(
        create: (context) => AppSettingsBloc(),
      ),
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
      )
    ],
    child: MyApp(),
  ));
}
