import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/game_state.dart';
import 'day_phase_screen.dart';
import 'night_phase_screen.dart';
import 'ending_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    _startGameLoop();
  }

  void _startGameLoop() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        context.read<GameProvider>().updateGameTime();
        _startGameLoop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, _) {
        switch (gameProvider.gameState.phase) {
          case GamePhase.day:
            return const DayPhaseScreen();
          case GamePhase.night:
            return const NightPhaseScreen();
          case GamePhase.ending:
            return const EndingScreen();
          default:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
        }
      },
    );
  }
}
