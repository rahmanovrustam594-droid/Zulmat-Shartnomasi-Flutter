enum GamePhase { mainMenu, day, night, ending }

class GameState {
  GamePhase phase = GamePhase.mainMenu;
  bool isDayTime = true;
  int dayCounter = 0;
  int minutesElapsed = 0;
  int totalMinutes = 15; // 15 minutes per phase
  
  // Ending system
  int cardDemonVictories = 0;
  bool hasArtifactFromDemon = false;
  bool hasArtifactFromLabyrinth = false;
  
  void updateTime() {
    minutesElapsed++;
    if (minutesElapsed >= totalMinutes) {
      togglePhase();
      minutesElapsed = 0;
    }
  }
  
  void togglePhase() {
    isDayTime = !isDayTime;
    if (!isDayTime) {
      dayCounter++;
    }
    phase = isDayTime ? GamePhase.day : GamePhase.night;
  }
  
  double getPhaseProgress() => minutesElapsed / totalMinutes;
}
