/* import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:affirm/Frontend/Models/audio_model.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart' as path;

class EqubNotifier with ChangeNotifier {
  EqubNotifier() {
    _readEqubsFromStorage().then(
      (value) => {
        _equbList.addAll(value),
        notifyListeners(),
      },
    );
  }
  List<AudioModel> _equbList = [];

  UnmodifiableListView<AudioModel> get equbList =>
      UnmodifiableListView(_equbList);
  List<AudioModel> get eQubList => new List.empty(); //new List<AudioModel>();

  void addEqub(AudioModel equb) {
    _equbList.add(equb);
    _writeEqubsToStorage(_equbList);
    notifyListeners();
  }

  void deleteEqub(AudioModel equb) {
    _equbList.remove(equb);
    _writeEqubsToStorage(_equbList);
    notifyListeners();
  }
}

Future<File> _writeEqubsToStorage(List<AudioModel> equb) async {
  final dir = await path.getApplicationDocumentsDirectory();
  final file = File('${dir.path}/equb.json');

  return file.writeAsString(
    json.encode(equb.map((e) => e.toJson()).toList()),
  );
}

Future<List<AudioModel>> _readEqubsFromStorage() async {
  final dir = await path.getApplicationDocumentsDirectory();
  final file = File('${dir.path}/equb.json');
  if (await file.exists()) {
    final jsonStr = await file.readAsString();
    final decode = json.decode(jsonStr);
    return decode.map<AudioModel>((x) => AudioModel.fromJson(x)).toList();
  } else {
    return <AudioModel>[];
  }
}
 */