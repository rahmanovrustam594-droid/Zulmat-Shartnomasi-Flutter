class Enemy {
  final String id;
  final String name;
  final String type; // 'mutant', 'shadow_wizard', 'labyrinth_keeper'
  int health;
  final int maxHealth;
  final int damage;
  final int reward;
  double x = 0;
  double y = 0;

  Enemy({
    required this.id,
    required this.name,
    required this.type,
    required this.maxHealth,
    required this.damage,
    required this.reward,
  }) : health = maxHealth;

  bool isAlive() => health > 0;
  
  void takeDamage(int amount) {
    health = (health - amount).clamp(0, maxHealth);
  }
  
  void heal() {
    health = maxHealth;
  }
}
