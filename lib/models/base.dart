class Base {
  int woodWalls = 0;
  int stoneWalls = 0;
  int ironWalls = 0;
  int torches = 0;
  int furnace = 0; // 0 = none, 1 = building, 2 = built
  int signalTower = 0; // 0-100 (build progress)
  int maxWallHealth = 50;
  int wallHealth = 50;
  
  bool isDestroyed() => wallHealth <= 0;
  
  void takeDamage(int damage) {
    wallHealth = (wallHealth - damage).clamp(0, maxWallHealth);
  }
  
  void repair(int amount) {
    wallHealth = (wallHealth + amount).clamp(0, maxWallHealth);
  }
  
  void buildWall(String type, int amount) {
    switch (type) {
      case 'wood':
        woodWalls += amount;
        break;
      case 'stone':
        stoneWalls += amount;
        break;
      case 'iron':
        ironWalls += amount;
        break;
    }
  }
  
  void upgradeTower(int amount) {
    signalTower = (signalTower + amount).clamp(0, 100);
  }
}
