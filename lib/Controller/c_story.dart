import 'dart:collection';
import 'package:kids_learning/Model/m_learn.dart';

import 'package:kids_learning/views/storys_screen.dart';

class ControllerStory {
  static List<ModellStory> _datastory = [
    ModellStory(
      title: "اسراء اور معراج",
      page: Story1(),
    ),
    ModellStory(
      title: "اسلام کے ستون،",
      page: Story3(),
    ),
    ModellStory(
      title: "اذان کی کہانی",
      page: Story6(),
    ),
    ModellStory(
      title: "شہد کی مکھی اور تتلی کی کہانی",
      page: Story7(),
    ),
  ];

  static UnmodifiableListView<ModellStory> get datastory =>
      UnmodifiableListView(_datastory);

  static int get dataLength => _datastory.length;
}
