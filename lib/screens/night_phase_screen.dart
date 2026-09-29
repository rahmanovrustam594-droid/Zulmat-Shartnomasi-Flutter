import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class NightPhaseScreen extends StatelessWidget {
  const NightPhaseScreen({Key? key}) : super(key: key);

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
                  Color(0xFF0a0e27),
                  Color(0xFF1a1a3e),
                  Color(0xFF2d0052),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Header with time and danger
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      border: Border.bottom(
                        BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '⚠️ TUN FAZA - XAVFLI! ⚠️',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            shadows: [
                              Shadow(
                                blurRadius: 10,
                                color: Colors.red.withOpacity(0.5),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Vaqt: ${gameState.minutesElapsed}/${gameState.totalMinutes} min',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 10,
                            backgroundColor: Colors.grey[800],
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Warning
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red[900]!.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: Text(
                      '🌙 Qorongʻulik ichida mutantlar bazangizga hujum qilmoqda!\n🔦 Chirogʻ yoqilgan? Devorlaringiz himoya qiladi!\n✨ "Qora Eter" kristallarini qurish uchun yigʻing!',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
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
                              'Baza Health: ${gameProvider.base.wallHealth}',
                              style: TextStyle(
                                color: Colors.orange,
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
                  // Night Activities
                  Text(
                    'Tun Faoliyatlari',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00d4ff),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _NightActionButton(
                          label: '✨ Qora Eter Yigʻish',
                          description: 'Faqat tunda paydo boʻladigan kristallar',
                          onPressed: () {
                            gameProvider.gatherResource('blackEther', 3);
                          },
                        ),
                        _NightActionButton(
                          label: '🛡️ Bazani Himoya Qilish',
                          description: 'Mutantlardan devorlarni qo\'l tutish',
                          onPressed: () {
                            gameProvider.defendAgainstAttack();
                          },
                        ),
                        _NightActionButton(
                          label: '🔥 Minora Yoqish',
                          description: 'Signal Minorasi va orol himoyasi',
                          onPressed: () {
                            gameProvider.upgradeTower();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Special Night Encounters
                  Text(
                    'Xavfli To\'qonalar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFe94560),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        _EncounterCard(
                          title: '🃏 Karta Iblisi (Arxivarius)',
                          description: '3 daqiqalik karta oʻyini o\'yna.\nYutsa: noyob resurs\nYutqazsa: 50% sog\'liq kamayi',
                          onEncounter: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Karta Oʻyini'),
                                content: Text('Oʻyin mexanikasi hozir qayta tayyorlanmoqda...'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      gameProvider.playCardGame(true);
                                    },
                                    child: Text('Yut'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      gameProvider.playCardGame(false);
                                    },
                                    child: Text('Yutqa'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        _EncounterCard(
                          title: '👁️ Soyali Labirintchi',
                          description: '1 daqiqaga "Soya Olami" ga tortib ketadi.\nMexanizmni yoqib chiqsangiz qutulasiz!',
                          onEncounter: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Soya Olamidan chiqish uchun mexanizmni toping!')),
                            );
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

class _NightActionButton extends StatelessWidget {
  final String label;
  final String description;
  final VoidCallback onPressed;

  const _NightActionButton({
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
          backgroundColor: Color(0xFF8b0000),
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
                color: Colors.orange[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EncounterCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onEncounter;

  const _EncounterCard({
    required this.title,
    required this.description,
    required this.onEncounter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple[900]!.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.purple, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00d4ff),
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onEncounter,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFe94560),
              ),
              child: Text('Uchrashni O\'ta'),
            ),
          ),
        ],
      ),
    );
  }
}
