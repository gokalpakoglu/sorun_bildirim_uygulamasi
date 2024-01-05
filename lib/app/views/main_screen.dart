import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sorun_bildirim_uygulamasi/core/extension/context_extension.dart';
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
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home), label: context.loc.home),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings), label: context.loc.settings),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person), label: context.loc.profile),
        ],
      ),
    );
  }
}
