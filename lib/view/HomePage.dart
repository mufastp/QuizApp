import 'dart:convert';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';




import 'package:http/http.dart' as http;
import 'package:quizapp2/view/result.dart';


import '../controller/provider.dart';
import '../model/model.dart';
import '../utility/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  bool match = false;
  int mark = 0;
  int buttonIndex = -1;
  int pageIndex = 1;
  int indexfornextque = 0;

  List<String> optinosIndictor = ['A.', "B.", "C.", "D.", "E."];

  @override
  Widget build(BuildContext context) {
    return Consumer<QustionsProvider>(builder: (context, getdata, child) {
      getdata.fetchQuestion();
      if (getdata.status == ProviderStatus.COMPLETED) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Quiz',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                width: 420,
                height: 180,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        height: 35,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  offset: Offset(-1, 1),
                                  blurRadius: 5,
                                  color: Colors.black)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            '$pageIndex/10',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //questions
                      Text(getdata.data[0].questions[indexfornextque].question)
                    ],
                  ),
                ),
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
                color: Colors.black,
                thickness: 1,
              ),
              Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(-1, 1),
                        blurRadius: 5,
                        color: Colors.black)
                  ],
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.question_mark),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('Choose an answer'),
              SizedBox(
                height: 350,
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(10),
                        width: 320,
                        height: 60,
                        decoration: BoxDecoration(
                            color: index != buttonIndex
                                ? Colors.blue
                                : Colors.black,
                            borderRadius: BorderRadius.circular(10)),

                        child: TextButton(
                            onPressed: (() {
                              buttonIndex = index;
                            getdata.answerCheck(buttonIndex, pageIndex, index,
                                  getdata.data[0].questions[indexfornextque].correctIndex);
                              buttonIndex = index;
                              // print(
                              //   datas['questions'][pageIndex]['answers'][index],
                              // );
                            }),
                            child: Row(
                              children: [
                                Text(
                                  optinosIndictor[index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 150,
                                ),
                                Text(
                                  getdata.data[0].questions[indexfornextque]
                                      .answers[index],
                                  style: const TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                        // ),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 280),
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(-1, 1),
                            blurRadius: 5,
                            color: Colors.black)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      print(context.read<QustionsProvider>().match);
                      getdata.pageChange();

                      indexfornextque++;

                      pageIndex < 10
                          ? pageIndex++
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ResultPage()));
                      buttonIndex = -1;
                      match = false;
                      print('marks ${context.read<QustionsProvider>().mark}');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return const CircularProgressIndicator();
      }
    }); 
  }
}
