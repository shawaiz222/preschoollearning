import 'package:flutter/material.dart';
import 'package:kids_learning/Component/appBar.dart';
import 'package:kids_learning/Component/card_Screen_story.dart';
import 'package:kids_learning/Controller/c_screen_story.dart';
import 'package:kids_learning/Model/m_learn.dart';

class Story1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(
        title: "اسراء اور معراج",
      ),
      body: ListView.builder(
        itemCount: ControllerScreenStory1.dataLength,
        itemBuilder: (context, index) {
          MaodellScreenStory story =
              ControllerScreenStory1.dataStory.elementAt(index);
          return CardScreenStory(
            data: story,
          );
        },
      ),
    );
  }
}

class Story3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(
        title: 'أركان الإسلام',
      ),
      body: ListView.builder(
        itemCount: ControllerScreenStory3.dataLength,
        itemBuilder: (context, index) {
          MaodellScreenStory story =
              ControllerScreenStory3.dataStory.elementAt(index);
          return CardScreenStory(
            data: story,
          );
        },
      ),
    );
  }
}

///////////////////////////////////////////
class Story6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(
        title: "اذان کی کہانی",
      ),
      body: Container(
        child: Image.asset(
          'assets/images/story6.jpg',
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////
class Story7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(
        title: "شہد کی مکھی اور تتلی کی کہانی",
      ),
      body: Container(
        child: Image.asset(
          'assets/images/story7.jpg',
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
