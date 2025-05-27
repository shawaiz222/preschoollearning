// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../controller/gameController.dart';

class GameView extends StatefulWidget {
  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final controller = Get.put(GameController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.backgroundPlayer.dispose();
    controller.gameOverPlayer.dispose();
    controller.jumpPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Obx(() {
        return GestureDetector(
          onTap: () {
            if (controller.gameStarted.value) {
              controller.jump();
            } else {
              controller.startGame();
            }
          },
          child: Stack(
            children: [
              Container(
                height: Get.height,
                width: Get.width,
                child: Image.asset('assets/images/background.jpg',
                    cacheWidth: 800, fit: BoxFit.fitHeight),
              ),
              Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      // Dino
                      Align(
                        alignment: Alignment(0, controller.dinoY.value),
                        child: Container(
                            child: Image.asset(
                          'assets/gifs/dino.gif',
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                        )),
                      ),
                      // Obstacle
                      AnimatedContainer(
                        alignment: controller.checkEven(controller.count.value)
                            ? Alignment(controller.obstacleX.value, .4)
                            : Alignment(controller.obstacleX.value, 1),
                        duration: Duration(milliseconds: 0),
                        child: Obx(
                          () => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              controller.count.toString(),
                              style: TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                color: controller.currentColor.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Score & UI
                      Obx(
                        () => Align(
                          alignment: controller.gameStarted.value
                              ? Alignment(0, -0.9)
                              : Alignment.center,
                          child: Text(
                            controller.gameStarted.value
                                ? "Score: ${controller.score}"
                                : "TAP TO START",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      if (!controller.gameStarted.value &&
                          controller.score.value > 0)
                        Obx(
                          () => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 100),
                            child: Text(
                              "Your Score: ${controller.score}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      if (!controller.gameStarted.value &&
                          controller.score.value > 0)
                        Center(
                          child: InkWell(
                            onTap: controller.resetGame,
                            child: Container(
                              height: 50,
                              width: Get.width - Get.width * .2,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.orange.shade800),
                              child: const Center(
                                  child: Text(
                                "RESTART",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => !controller.showWon.value
                    ? SizedBox()
                    : Container(
                        width: Get.width,
                        height: Get.height,
                        child: Center(
                          child: Stack(
                            children: [
                              Container(
                                height: Get.height,
                                width: Get.width,
                                child: Image.asset(
                                    'assets/images/background.jpg',
                                    fit: BoxFit.fitHeight),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      'assets/gifs/won.json',
                                      repeat: true,
                                    ),
                                    Text(
                                      "Score: ${controller.score}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: InkWell(
                                        onTap: controller.resetGame,
                                        child: Container(
                                          height: 50,
                                          width: Get.width - Get.width * .2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.orange.shade800),
                                          child: const Center(
                                              child: Text(
                                            "RESTART",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              )
            ],
          ),
        );
      }),
    );
  }
}
