import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  RxInt count = 1.obs;
  Rx<MaterialColor> currentColor = Colors.red.obs;

  var dinoY = 1.0.obs;
  var dinoX = 0.0.obs; // Horizontal movement for the jump
  var obstacleX = 1.0.obs;
  var score = 0.obs;
  var isJumping = false.obs;
  var gameStarted = false.obs;
  var showWon = false.obs;
  var obstaclePassed = false.obs; // Track if the obstacle has already passed

  Timer? gameLoop;
  final List<MaterialColor> customColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.orange,
  ];

  final backgroundPlayer = AudioPlayer();

  void playBackgorund() {
    print("jump played");
    backgroundPlayer.play(AssetSource('tones/background.mp3'),
        volume: 50, mode: PlayerMode.mediaPlayer);
    Timer.periodic(const Duration(seconds: 50), (timer) async {
      await backgroundPlayer.stop();
      await backgroundPlayer.play(AssetSource('tones/background.mp3'),
          volume: 50);
    });
  }

  final jumpPlayer = AudioPlayer();

  void playJump() async {
    print("jump played");
    await jumpPlayer.play(AssetSource('tones/jump.mp3'), volume: 100);
  }

  final gameOverPlayer = AudioPlayer();

  void playGameOver() async {
    print("game overplayed");
    await gameOverPlayer.play(AssetSource('tones/gameOver.mp3'), volume: 100);
  }

  void startGame() {
    resetGame();
    playBackgorund();
    gameStarted.value = true;
    obstacleX.value = 1.0;
    score.value = 0;

    gameLoop = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (obstacleX.value < -1.2) {
        obstacleX.value = 1.0;
        count.value++;
        changeColor();
        obstaclePassed.value = false; // Reset for the new obstacle
      } else {
        obstacleX.value -= isJumping.value ? 0.04 : 0.02;
      }

      // Check if obstacle has passed the dino's x position
      if (!obstaclePassed.value && obstacleX.value < dinoX.value) {
        obstaclePassed.value = true;
        if (!detectCollision()) {
          score.value++;
          if (score.value >= 50) {
            showWon.value = true;
            timer.cancel();
            gameStarted.value = false;
          }
        }
      }

      if (detectCollision()) {
        timer.cancel();
        gameStarted.value = false;
        playGameOver();
      }
    });
  }

  bool detectCollision() {
    if (checkEven(count.value)) {
      return false;
    } else {
      return (obstacleX.value < 0.1 &&
          obstacleX.value > -0.1 &&
          dinoY.value >= 1.0);
    }
  }

  void jump() {
    if (!isJumping.value) {
      isJumping.value = true;

      double time = 0;
      const double gravity = -4.9;
      const double velocity = 3.5;
      const double initialPos = 1.0;
      const double jumpDuration = 1.0; // roughly 1 second
      playJump();

      Timer.periodic(Duration(milliseconds: 30), (timer) {
        time += 0.05;

        // Vertical jump height
        double height = gravity * time * time + velocity * time;
        dinoY.value = (initialPos - height) - 1;

        // Horizontal forward movement using sine
        dinoX.value = 0.2 * sin(pi * time / jumpDuration);

        if (dinoY.value > 1.0) {
          dinoY.value = 1.0;
          dinoX.value = 0.0;
          isJumping.value = false;
          timer.cancel();
        }
      });
    }
  }

  int getRandomNumber() {
    final random = Random();
    return random.nextInt(7); // Generates a number from 0 to 6 (inclusive)
  }

  void changeColor() {
    int random = getRandomNumber();
    final newColor = customColors[random];
    currentColor.value = newColor;
  }

  void resetGame() {
    showWon.value = false;
    dinoY.value = 1.0;
    dinoX.value = 0.0;
    obstacleX.value = 1.0;
    score.value = 0;
    count.value = 1;
    gameStarted.value = false;
    isJumping.value = false;
    obstaclePassed.value = false;
    gameLoop?.cancel();
  }

  bool checkEven(int number) {
    return number % 2 == 0;
  }
}
