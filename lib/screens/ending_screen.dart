import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import 'main_menu_screen.dart';

class EndingScreen extends StatelessWidget {
  const EndingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, _) {
        final base = gameProvider.base;
        final player = gameProvider.player;
        final hasArtifact1 = gameProvider.gameState.hasArtifactFromDemon;
        final hasArtifact2 = gameProvider.gameState.hasArtifactFromLabyrinth;
        final cardVictories = gameProvider.gameState.cardDemonVictories;

        String endingTitle = '';
        String endingDescription = '';
        Color endingColor = Colors.white;

        // Determine ending
        if (hasArtifact1 && hasArtifact2) {
          endingTitle = '🌟 YAKUN 4: ZULMATNI YOʻQ QILISH 🌟';
          endingDescription =
              'Siz Karta Iblisi va Labirintchidan 2 ta legendar artefakt yig\'ladi va Minora yadrosiga o\'rnatdingiz.\n\n'
              'Minora osmonga ortiqcha ultraviyolet nur sochdi. Xaritadagi barcha yovuzlik va maxluqlar kulga aylanib ketdi.\n'
              'Orol abadiy laʼnatdan xalos boʻldi.\n\n'
              'OʻYIN GʻALABA BILAN TUGADI! 🎉';
          endingColor = Colors.cyan;
        } else if (cardVictories >= 5) {
          endingTitle = '👑 YAKUN 3: YANGI LORD 👑';
          endingDescription =
              'Siz Karta Iblisi bilan 5 marta ketma-ket oʻynab, barchasida gʻalaba qozdingiz!\n\n'
              'Karta Iblisi (Arxivarius) oʻz taxtini sizga topshirdi.\n'
              'Siz zulmatning yangi hukmdori boʻlib, keyingi sayyohlarni stol qarshisida kutasiz...\n\n'
              'OʻYIN TUGADI! 🎭';
          endingColor = Colors.purple;
        } else if (base.isDestroyed() || player.health <= 0) {
          endingTitle = '💀 YAKUN 2: ZULMAT QURBONI (YOMONa YAKUN) 💀';
          endingDescription =
              'Vaqt yetmay qoldi! Bazangiz mutantlar tomonidan butunlay vayron boʻldi.\n\n'
              'Siz qorongʻulikda ojiz qoldingiz. Soyali Labirintchi sizni Soya Olamiga abadiy tortib ketdi.\n\n'
              'OʻYIN TUGADI... 😢';
          endingColor = Colors.red;
        } else if (base.signalTower >= 100) {
          endingTitle = '🚁 YAKUN 1: QUTQARUV AVIASIYASI 🚁';
          endingDescription =
              'Siz Minoraning qurilishini yakunlagansiz!\n\n'
              'Minora osmonga qizil nur sochdi. Barcha maxluqlar bazangizga gʻazab bilan hujum qildi.\n'
              '3 daqiqa davomida bazani himoya qildingiz va qutqaruv vertolyoti kelib sizni olib ketdi!\n\n'
              'OʻYIN GʻALABA BILAN TUGADI! 🎉';
          endingColor = Colors.green;
        }

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
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ending Title
                      Text(
                        endingTitle,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: endingColor,
                          shadows: [
                            Shadow(
                              blurRadius: 20,
                              color: endingColor.withOpacity(0.5),
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      // Ending Description
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: endingColor, width: 2),
                        ),
                        child: Text(
                          endingDescription,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            height: 1.6,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 40),
                      // Stats
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'FINALLASHGAN STATISTIKA',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                              ),
                            ),
                            SizedBox(height: 15),
                            _StatRow('Kunlar', gameProvider.gameState.dayCounter.toString()),
                            _StatRow('Yogʻoch', player.wood.toString()),
                            _StatRow('Tosh', player.stone.toString()),
                            _StatRow('Temir', player.iron.toString()),
                            _StatRow('Qora Eter', player.blackEther.toString()),
                            _StatRow('Minora Tayyorligi', '${base.signalTower}/100'),
                            _StatRow('Karta Oʻyini Galib', cardVictories.toString()),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      // Menu Button
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const MainMenuScreen()),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                          backgroundColor: endingColor,
                        ),
                        child: Text(
                          'ASOSIY MENU GA QAYTAR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.cyan,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
