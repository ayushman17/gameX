import 'package:gameX/components/enemy.dart';
import 'package:gameX/game_controller.dart';

class EnemySpawner {
  final GameController gameController;
  final int maxSpawnerInterval = 3000;
  final int minSpawnerInterval = 700;
  final int intervalChange = 3;
  final int maxEnemies = 7;
  int currentInterval;
  int nextSpawn;

  EnemySpawner(this.gameController) {
    initialize();
  }

  void initialize() {
    killAllEnemies();
    currentInterval = maxSpawnerInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAllEnemies() {
    gameController.enemies.forEach((Enemy enemy) => enemy.isDead = true);
  }

  void update(double t) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (gameController.enemies.length < maxEnemies && now >= nextSpawn) {
      gameController.spawnEnemy();
      if (currentInterval > minSpawnerInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * 0.1).toInt();
      }
      nextSpawn = now + currentInterval;
    }
  }
}
