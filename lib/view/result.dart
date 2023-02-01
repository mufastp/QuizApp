import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';



import '../controller/provider.dart';
import 'HomePage.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool win = context.read<QustionsProvider>().mark >= 5;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Center(
            child: Text(
              'Result',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
        body: Stack(
          children: [
            win
                ? LottieBuilder.network(
                    'https://assets7.lottiefiles.com/packages/lf20_ahrbr631.json')
                : Align(
                    alignment: Alignment.center,
                    child: LottieBuilder.network(
                        'https://assets8.lottiefiles.com/private_files/lf30_uDAsLk.json'),
                  ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 400),
                    child: CircularPercentIndicator(
                      animation: true,
                      // animationDuration: 1000,
                      radius: 85,
                      lineWidth: 20,
                      percent: context.read<QustionsProvider>().mark / 10,
                      center: Text(
                        "${context.read<QustionsProvider>().mark}/10",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      progressColor: win ? Colors.green : Colors.red,
                      backgroundColor: Colors.white,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: FloatingActionButton.extended(
                        backgroundColor: win ? Colors.lightGreen : Colors.red,
                        onPressed: (() {
                          context
                              .read<QustionsProvider>()
                              .pageChange(reset: true);

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => HomePage()));
                        }),
                        label: win
                            ? const Text(
                                "Awesome",
                                style: TextStyle(fontSize: 20),
                              )
                            : const Text(
                                'Oooops.....!',
                                style: TextStyle(fontSize: 20),
                              )),
                  ),
                  win
                      ? const Text(
                          '\t\t\t\t\t\t\tCongratulations\nYou Passed The exam ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      : TextButton(
                          onPressed: (() {
                            // context.read<QustionsProvider>().mark = 0;
                            context
                                .read<QustionsProvider>()
                                .pageChange(reset: true);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (ctx) => HomePage()));
                          }),
                          child: const Text(
                            'try again',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                ],
              ),
            )
          ],
        ));
  }
}
