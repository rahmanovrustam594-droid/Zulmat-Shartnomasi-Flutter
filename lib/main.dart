import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_menu_screen.dart';
import 'providers/game_provider.dart';

void main() {
  runApp(const ZulmatApp());
}

class ZulmatApp extends StatelessWidget {
  const ZulmatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
      ],
      child: MaterialApp(
        title: 'Zulmat Shartnomasi',
        theme: ThemeData.dark().copyWith(
          primaryColor: const Color(0xFF1a1a2e),
          scaffoldBackgroundColor: const Color(0xFF0f3460),
        ),
        home: const MainMenuScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
