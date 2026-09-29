class Player {
  int health = 100;
  int maxHealth = 100;
  
  // Resources
  int wood = 0;
  int stone = 0;
  int iron = 0;
  int blackEther = 0;
  int tools = 0;
  
  // Stats
  int level = 1;
  int experience = 0;
  
  // Items
  List<String> inventory = [];
  
  Player();
  
  void takeDamage(int damage) {
    health = (health - damage).clamp(0, maxHealth);
  }
  
  void heal(int amount) {
    health = (health + amount).clamp(0, maxHealth);
  }
  
  void addResource(String type, int amount) {
    switch (type) {
      case 'wood':
        wood += amount;
        break;
      case 'stone':
        stone += amount;
        break;
      case 'iron':
        iron += amount;
        break;
      case 'blackEther':
        blackEther += amount;
        break;
    }
  }
  
  void reset() {
    health = maxHealth;
    wood = 0;
    stone = 0;
    iron = 0;
    blackEther = 0;
    tools = 0;
    level = 1;
    experience = 0;
    inventory.clear();
  }
}
