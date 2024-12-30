import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:readventure/view/components/custom_navigation_bar.dart';
import 'package:readventure/viewmodel/app_state_controller.dart';
import 'package:readventure/viewmodel/theme_controller.dart';

class MyHomePage extends ConsumerWidget { // ConsumerWidget으로 변경
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider); // 사용자 상태
    final themeController = ref.read(themeProvider.notifier); // 테마 컨트롤러
    final isLightTheme = ref.watch(themeProvider); // 현재 테마 상태

    return Scaffold(
      appBar: AppBar(
        title: const Text('app_title').tr(),
        actions: [
          IconButton(
            icon: Icon(isLightTheme ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeController.toggleTheme(); // 테마 변경
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              appState?.email ?? 'No User Logged In', // 사용자 이메일 표시
              style: const TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(appStateProvider.notifier).clearUser(); // 사용자 로그아웃
              },
              child: const Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('ko')); // 한국어로 전환
              },
              child: const Text('Switch to Korean'),
            ),
            ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('en')); // 영어로 전환
              },
              child: const Text('Switch to English'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(), // 네비게이션 바
    );
  }
}