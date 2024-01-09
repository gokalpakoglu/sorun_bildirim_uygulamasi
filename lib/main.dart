import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get_storage/get_storage.dart';
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
  await GetStorage.init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<RegisterBloc>(create: (context) => RegisterBloc()),
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
      ),
      BlocProvider<ProfileBloc>(
        create: (context) => ProfileBloc()..add(InitialProfile()),
      ),
      BlocProvider<AppSettingsBloc>(
        create: (context) => AppSettingsBloc()..add(const InitialAppSettings()),
      ),
      BlocProvider<HomeBloc>(
        create: (context) => HomeBloc()..add(InitialHome()),
      )
    ],
    child: MyApp(),
  ));
}
