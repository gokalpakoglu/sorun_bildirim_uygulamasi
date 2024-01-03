import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/authentication/bloc/authentication_bloc.dart';

class HomeScreen extends StatelessWidget {
  static String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello User',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationLoading) {
                  const CircularProgressIndicator();
                } else if (state is AuthenticationFailure) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: Text('error'),
                        );
                      });
                }
              },
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(LogOut());
                    },
                    child: const Text('logOut'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
