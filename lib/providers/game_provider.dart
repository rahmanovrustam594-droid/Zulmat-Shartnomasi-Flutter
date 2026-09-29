import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/base.dart';
import '../models/game_state.dart';
import '../models/enemy.dart';

class GameProvider extends ChangeNotifier {
  late Player player;
  late Base base;
  late GameState gameState;
  List<Enemy> enemies = [];
  
  GameProvider() {
    _initializeGame();
  }
  
  void _initializeGame() {
    player = Player();
    base = Base();
    gameState = GameState();
  }
  
  void startNewGame() {
    player.reset();
    base = Base();
    gameState = GameState();
    gameState.phase = GamePhase.day;
    enemies.clear();
    notifyListeners();
  }
  
  void updateGameTime() {
    gameState.updateTime();
    
    if (gameState.isDayTime) {
      // Day phase logic
    } else {
      // Night phase logic - spawn enemies
      if (gameState.minutesElapsed == 0) {
        spawnEnemies();
      }
    }
    notifyListeners();
  }
  
  void spawnEnemies() {
    enemies.clear();
    int mutantCount = 2 + gameState.dayCounter;
    
    for (int i = 0; i < mutantCount; i++) {
      enemies.add(Enemy(
        id: 'mutant_$i',
        name: 'Mutant',
        type: 'mutant',
        maxHealth: 20 + (gameState.dayCounter * 2),
        damage: 5 + gameState.dayCounter,
        reward: 10,
      ));
    }
  }
  
  void gatherResource(String type, int amount) {
    player.addResource(type, amount);
    notifyListeners();
  }
  
  void craftItem(String itemType) {
    switch (itemType) {
      case 'wooden_axe':
        if (player.wood >= 5) {
          player.wood -= 5;
          player.tools++;
          player.inventory.add('Wooden Axe');
        }
        break;
      case 'stone_axe':
        if (player.stone >= 10 && player.wood >= 3) {
          player.stone -= 10;
          player.wood -= 3;
          player.tools++;
          player.inventory.add('Stone Axe');
        }
        break;
      case 'iron_pickaxe':
        if (player.iron >= 15 && player.stone >= 5) {
          player.iron -= 15;
          player.stone -= 5;
          player.tools++;
          player.inventory.add('Iron Pickaxe');
        }
        break;
    }
    notifyListeners();
  }
  
  void buildWall(String wallType) {
    switch (wallType) {
      case 'wood':
        if (player.wood >= 10) {
          player.wood -= 10;
          base.buildWall('wood', 1);
        }
        break;
      case 'stone':
        if (player.stone >= 15) {
          player.stone -= 15;
          base.buildWall('stone', 1);
        }
        break;
      case 'iron':
        if (player.iron >= 20) {
          player.iron -= 20;
          base.buildWall('iron', 1);
        }
        break;
    }
    notifyListeners();
  }
  
  void upgradeTower() {
    if (player.blackEther >= 5) {
      player.blackEther -= 5;
      base.upgradeTower(10);
      notifyListeners();
    }
  }
  
  void defendAgainstAttack() {
    base.takeDamage(10);
    if (base.isDestroyed()) {
      endGame('destroyed');
    }
    notifyListeners();
  }
  
  void playCardGame(bool won) {
    if (won) {
      cardDemonVictories++;
      player.addResource('blackEther', 20);
      if (cardDemonVictories >= 5) {
        hasArtifactFromDemon = true;
      }
    } else {
      player.takeDamage(50);
      if (player.health <= 0) {
        endGame('defeated');
      }
    }
    notifyListeners();
  }
  
  void endGame(String reason) {
    gameState.phase = GamePhase.ending;
    notifyListeners();
  }
  
  int get cardDemonVictories => gameState.cardDemonVictories;
  
  void setCardDemonVictory() {
    gameState.cardDemonVictories++;
    if (gameState.cardDemonVictories >= 1) {
      gameState.hasArtifactFromDemon = true;
    }
    notifyListeners();
  }
}
