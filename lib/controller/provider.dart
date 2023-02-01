import 'package:flutter/cupertino.dart';


import 'package:http/http.dart' as http;

import '../model/model.dart';
import '../utility/constants.dart';

class QustionsProvider with ChangeNotifier {
  bool match = false;
  int mark = 0;
  List<Question> data = [];
  ProviderStatus status = ProviderStatus.LOADING;
  void pageChange({bool reset = false}) {
    print(match);

    if (match) {
      mark++;
      match = false;
    }
    if (reset) {
      mark = 0;
    }

    notifyListeners();
  }

  Future<void> answerCheck(
      int buttonindex, pageindex, index, int correctIndex) async {
    print('curentindx is' + '${correctIndex}');
    print('button inex is' + '${buttonindex}');
    buttonindex = index;
    buttonindex == correctIndex ? match = true : match = false;
    print(buttonindex);
    print(match);
    print(pageindex);
    notifyListeners();
  }

  fetchQuestion() async {
    final response = await http
        .get(Uri.parse('https://637dbfffcfdbfd9a639bba1e.mockapi.io/sample'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      data = questionFromJson(response.body);
      status = ProviderStatus.COMPLETED;
    } else {
      throw Exception('Failed to load album');
    }
    notifyListeners();
  }
}
