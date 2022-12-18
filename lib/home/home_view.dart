import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livastro_assignment/home/bottom_bar_view.dart';
import 'package:livastro_assignment/home/list_item.dart';
import 'package:livastro_assignment/home/top_bar_item_view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String chars = 'abcdefghijklmnopqrstuvwxyz';

  final TextEditingController numBoxesController =
      TextEditingController(text: '0');
  final TextEditingController maxNumSelectionsController =
      TextEditingController(text: '0');
  final TextEditingController maxNumAlphabets =
      TextEditingController(text: '0');
  final TextEditingController maxNumNumbers = TextEditingController(text: '0');

  String message = 'Success';
  var selectedAlphabets = <String>[];
  var selectedNums = <int>[];

  Future<LinkedHashMap<String, dynamic>> readJson() async {
    final String response = await rootBundle.loadString('assets/file.json');
    return json.decode(response);
  }

  validateInputs() {
    setState(() {
      message = "Success";

      if (int.parse(numBoxesController.text) > 11) {
        message =
            "Only Max of 11 select boxes can be created enter value less tha or equal to 11";
      }

      if (int.parse(maxNumSelectionsController.text) >
          int.parse(numBoxesController.text) * 2) {
        message =
            "You cannot enter value more than ${int.parse(numBoxesController.text) * 2} in Max No of Selections.";
      }

      if ((int.parse(maxNumAlphabets.text) + int.parse(maxNumNumbers.text)) >
          int.parse(maxNumSelectionsController.text)) {
        message =
            "You cannot enter value more than ${int.parse(numBoxesController.text)} in Max No of Alphabets";
      }

      if ((int.parse(maxNumNumbers.text) + int.parse(maxNumAlphabets.text)) >
          int.parse(maxNumSelectionsController.text)) {
        message =
            "You cannot enter value more than ${int.parse(numBoxesController.text)} in Max No of Numbers";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    numBoxesController.addListener(() {
      maxNumSelectionsController.text =
          (int.parse(numBoxesController.text) * 2).toString();
      maxNumAlphabets.text = numBoxesController.text;
      maxNumNumbers.text = numBoxesController.text;

      selectedAlphabets.clear();
      selectedNums.clear();
      validateInputs();
    });
    maxNumSelectionsController.addListener(() {
      selectedAlphabets.clear();
      selectedNums.clear();
      validateInputs();
    });
    maxNumAlphabets.addListener(() {
      selectedAlphabets.clear();
      validateInputs();
    });
    maxNumNumbers.addListener(() {
      selectedNums.clear();
      validateInputs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readJson(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(242),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TopBarItemView(
                          title: snapshot.data!['header_0'],
                          controller: numBoxesController),
                      Divider(
                        color: Colors.grey.shade800,
                      ),
                      TopBarItemView(
                        title: snapshot.data!['header_1'],
                        controller: maxNumSelectionsController,
                      ),
                      TopBarItemView(
                        title: snapshot.data!['header_2'],
                        controller: maxNumAlphabets,
                      ),
                      TopBarItemView(
                        title: snapshot.data!['header_3'],
                        controller: maxNumNumbers,
                      ),
                      const Divider(
                        height: 1,
                      )
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                                int.parse(numBoxesController.text),
                                (index) => ListItem(
                                      title: chars[index],
                                      isChecked: selectedAlphabets
                                          .contains(chars[index]),
                                      onChange: () {
                                        setState(() {
                                          if (selectedAlphabets
                                              .contains(chars[index])) {
                                            selectedAlphabets
                                                .remove(chars[index]);
                                          } else {
                                            if (selectedAlphabets.length ==
                                                int.parse(
                                                    maxNumAlphabets.text)) {
                                              var tempMessage = message;
                                              message =
                                                  "Unable to select as Max No of Alphabet reached (${maxNumAlphabets.text})";
                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                setState(() {
                                                  message = tempMessage;
                                                });
                                              });
                                            } else {
                                              selectedAlphabets
                                                  .add(chars[index]);
                                            }
                                          }
                                        });
                                      },
                                    ))),
                      ),
                      const VerticalDivider(),
                      Expanded(
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate(
                                int.parse(numBoxesController.text),
                                (index) => ListItem(
                                      title: index.toString(),
                                      isChecked: selectedNums.contains(index),
                                      onChange: () {
                                        setState(() {
                                          if (selectedNums.contains(index)) {
                                            selectedNums.remove(index);
                                          } else {
                                            if (selectedNums.length ==
                                                int.parse(maxNumNumbers.text)) {
                                              var tempMessage = message;
                                              message =
                                                  "Unable to select as Max No of Numbers reached (${maxNumNumbers.text})";
                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                setState(() {
                                                  message = tempMessage;
                                                });
                                              });
                                            } else {
                                              selectedNums.add(index);
                                            }
                                          }
                                        });
                                      },
                                    ))),
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: BottomBarView(
                message: message,
                onReset: () {
                  numBoxesController.text = "0";
                  maxNumSelectionsController.text = "0";
                  maxNumAlphabets.text = "0";
                  maxNumNumbers.text = "0";

                  selectedAlphabets.clear();
                  selectedNums.clear();
                  validateInputs();
                },
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
