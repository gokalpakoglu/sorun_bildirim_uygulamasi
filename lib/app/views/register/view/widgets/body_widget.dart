import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/bloc/register_bloc.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/register/view/widgets/get_current_location.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text('Email address'),
          const SizedBox(height: 5),
          TextFormField(
            onChanged: (value) {
              BlocProvider.of<RegisterBloc>(context)
                  .add(RegisterEmailChanged(email: value));
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 5),
          const Text('Password'),
          TextFormField(
            onChanged: (value) {
              BlocProvider.of<RegisterBloc>(context)
                  .add(RegisterPasswordChanged(password: value));
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your password',
            ),
            obscureText: false,
          ),
          const SizedBox(height: 5),
          const Text('Name'),
          TextFormField(
            onChanged: (value) {
              BlocProvider.of<RegisterBloc>(context)
                  .add(RegisterNameChanged(name: value));
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your name',
            ),
            obscureText: false,
          ),
          const SizedBox(height: 5),
          const Text('Surname'),
          TextFormField(
            onChanged: (value) {
              BlocProvider.of<RegisterBloc>(context)
                  .add(RegisterSurnameChanged(surname: value));
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your surname',
            ),
            obscureText: false,
          ),
          const SizedBox(height: 5),
          const Text('Location'),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const GetCurrentLocationView();
                }));
              },
              child: const Text("Get Current Location")),
          const SizedBox(height: 10),
          BlocConsumer<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state.appStatus.isLoaded) {
                //AppRouter().push(const HomeRoute());
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
              return SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // BlocProvider.of<AuthenticationBloc>(context).add(
                    //   RegisterUser(
                    //     emailController.text..toString().trim(),
                    //     passwordController.text.toString().trim(),
                    //     nameController.text.toString().trim(),
                    //     surnameController.text.toString().trim(),
                    //   ),
                    // );
                    BlocProvider.of<RegisterBloc>(context)
                        .add(RegisterSubmitted());
                  },
                  child: Text(
                    state.appStatus.isLoading ? '.......' : 'Signup',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
