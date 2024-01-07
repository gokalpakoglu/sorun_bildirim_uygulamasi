import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/app/views/home/view/widgets/body_widget.dart';
import 'package:sorun_bildirim_uygulamasi/core/common/app_bar_widget.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.gr.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) => (snapshot.hasData)
            ? Scaffold(
                appBar: AppBarWidget(
                  title: context.loc.appTitle,
                  actions: [
                    IconButton(
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (_) => AlertDialog(
                                    content:
                                        const Text('Çıkış Yapmak İstiyorm?'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                          // ignore: use_build_context_synchronously
                                          context.router.popUntilRoot();
                                        },
                                        child: const Text("Tamam"),
                                      ),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text("Vazgeç")),
                                    ],
                                  ));
                        },
                        icon: const Icon(Icons.logout_rounded)),
                  ],
                ),
                body: const BodyWidget(),
              )
            : Scaffold(
                appBar: AppBarWidget(
                  title: context.loc.appTitle,
                  actions: [
                    IconButton(
                        onPressed: () {
                          context.router.push(
                            const LoginRoute(),
                          );
                        },
                        icon: const Icon(Icons.login_sharp))
                  ],
                ),
                body: const BodyWidget(),
              ));
  }
}
