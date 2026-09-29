import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class DayPhaseScreen extends StatelessWidget {
  const DayPhaseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, _) {
        final player = gameProvider.player;
        final gameState = gameProvider.gameState;
        final progress = gameState.getPhaseProgress();

        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF87CEEB),
                  Color(0xFF90EE90),
                  Color(0xFF228B22),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header with time
                  Container(
                    padding: EdgeInsets.all(16),
                    color: Colors.black45,
                    child: Column(
                      children: [
                        Text(
                          'KUN FAZA - ${gameState.dayCounter + 1}-kun',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Vaqt: ${gameState.minutesElapsed}/${gameState.totalMinutes} min',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: Colors.grey[700],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.orangeAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Player Stats
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sog\'liq: ${player.health}/${player.maxHealth}',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Level: ${player.level}',
                              style: TextStyle(
                                color: Colors.cyan,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Resources
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: [
                            _ResourceChip(
                              icon: '🪵',
                              label: 'Yogʻoch',
                              amount: player.wood,
                            ),
                            _ResourceChip(
                              icon: '🪨',
                              label: 'Tosh',
                              amount: player.stone,
                            ),
                            _ResourceChip(
                              icon: '⚒️',
                              label: 'Temir',
                              amount: player.iron,
                            ),
                            _ResourceChip(
                              icon: '✨',
                              label: 'Qora Eter',
                              amount: player.blackEther,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Gathering Buttons
                  Text(
                    'Resurs Yigʻish',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _ActionButton(
                          label: '🪵 Yogʻoch Yigʻish',
                          onPressed: () {
                            gameProvider.gatherResource('wood', 5);
                          },
                        ),
                        _ActionButton(
                          label: '🪨 Tosh Yigʻish',
                          onPressed: () {
                            gameProvider.gatherResource('stone', 3);
                          },
                        ),
                        _ActionButton(
                          label: '⚒️ Temir Qazish',
                          onPressed: () {
                            gameProvider.gatherResource('iron', 2);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Crafting Section
                  Text(
                    'Tayyorlash',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _CraftButton(
                          label: '🪓 Yogʻoch Bolta',
                          description: '(5 yogʻoch)',
                          onPressed: () {
                            gameProvider.craftItem('wooden_axe');
                          },
                        ),
                        _CraftButton(
                          label: '🔨 Tosh Bolta',
                          description: '(10 tosh + 3 yogʻoch)',
                          onPressed: () {
                            gameProvider.craftItem('stone_axe');
                          },
                        ),
                        _CraftButton(
                          label: '⛏️ Temir Kazuvchi',
                          description: '(15 temir + 5 tosh)',
                          onPressed: () {
                            gameProvider.craftItem('iron_pickaxe');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Base Building
                  Text(
                    'Bazani Qurish',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _CraftButton(
                          label: '🪵 Yogʻoch Devor',
                          description: '(10 yogʻoch)',
                          onPressed: () {
                            gameProvider.buildWall('wood');
                          },
                        ),
                        _CraftButton(
                          label: '🪨 Tosh Devor',
                          description: '(15 tosh)',
                          onPressed: () {
                            gameProvider.buildWall('stone');
                          },
                        ),
                        _CraftButton(
                          label: '⚔️ Temir Devor',
                          description: '(20 temir)',
                          onPressed: () {
                            gameProvider.buildWall('iron');
                          },
                        ),
                        _CraftButton(
                          label: '🗼 Minora Tayyorlash',
                          description: 'Progress: ${gameProvider.base.signalTower}/100',
                          onPressed: () {
                            gameProvider.upgradeTower();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ResourceChip extends StatelessWidget {
  final String icon;
  final String label;
  final int amount;

  const _ResourceChip({
    required this.icon,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.cyan, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: TextStyle(fontSize: 18)),
          SizedBox(width: 8),
          Text(
            '$label: $amount',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12),
          backgroundColor: Colors.green[700],
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _CraftButton extends StatelessWidget {
  final String label;
  final String description;
  final VoidCallback onPressed;

  const _CraftButton({
    required this.label,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12),
          backgroundColor: Colors.blue[800],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
