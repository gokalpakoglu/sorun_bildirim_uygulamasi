import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/core/init/navigation/app_router.gr.dart';

@RoutePage()
class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        SettingsRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
        currentIndex: tabsRouter.activeIndex,
        onTap: (value) {
          tabsRouter.setActiveIndex(value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );

    // return AutoTabsRouter(
    //   routes: const [
    //     HomeRoute(),
    //     SettingsRoute(),
    //     ProfileRoute(),
    //   ],
    //   builder: (context, child) {
    //     final tabsRouter = AutoTabsRouter.of(context);
    //     return Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Sorun Bildirim Uygulamasi'),
    //       ),
    //       body: child,
    //       bottomNavigationBar: BottomNavigationBar(
    //         currentIndex: tabsRouter.activeIndex,
    //         onTap: (value) {
    //           tabsRouter.setActiveIndex(value);
    //         },
    //         items: const [
    //           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    //           BottomNavigationBarItem(
    //               icon: Icon(Icons.settings), label: "Settings"),
    //           BottomNavigationBarItem(
    //               icon: Icon(Icons.person), label: "Profile"),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
