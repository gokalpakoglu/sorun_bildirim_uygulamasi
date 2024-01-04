import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/bloc/register_bloc.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
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
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state.appStatus.isLoading) {
                const CircularProgressIndicator();
              } else if (state.appStatus.isError) {
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
                    // BlocProvider.of<RegisterBloc>(context).add(LogOut());
                  },
                  child: const Text('logOut'));
            },
          ),
        ],
      ),
    );
  }
}
