import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_learning/game/view/gameView.dart';
import '/Component/card_Apps.dart';
import '/Controller/c_apps.dart';
import '/Model/m_learn.dart';

class PageApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => GameView());
          },
          child: IgnorePointer(
            ignoring: true,
            child: CardApps(
                isLoading: false.obs,
                data: ModellPages(
                    imageUrl:
                        "https://media.pocketgamer.com/artwork/na-riyua/dino_run_2.jpg",
                    title: "Dino Run",
                    pageUrl: "")),
          ),
        )
      ],
    ));
  }
}
