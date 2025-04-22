import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:todoapp/constants/constants.dart';
import 'package:todoapp/models/models.dart';
import 'package:todoapp/widgets/widgets.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Taskmodel> modelsList = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  bool done = false;
  bool undone = false;
  late Searchbox searchBox; // Declare here, initialize in initState
  late Box<Taskmodel> mybox;

  Widget buildTask(int index) {
    final key = mybox.keyAt(index); // Get the real Hive key
    final task = mybox.get(key)!;

    String query = searchBox.getController().text.toLowerCase();

    if (done && !task.done) return const SizedBox.shrink();
    if (undone && task.done) return const SizedBox.shrink();
    if (query != "" &&
        !(task.title.toLowerCase().contains(query) ||
            task.subTitle.toLowerCase().contains(query))) {
      return const SizedBox.shrink();
    }

    return Task(
      model: task,
      oncheck: () {
        task.done = !task.done;
        setState(() {
          reload();
        });
      },
      ondelete: () async {
        await mybox.delete(key); // Use key instead of index
        setState(() {
          reload();
        });
      },
    );
  }

  void reload() {
    modelsList = mybox.values.toList();
  }

  Future<void> openBox() async {
    if (!Hive.isBoxOpen(Constants.boxname)) {
      await Hive.openBox<Taskmodel>(Constants.boxname);
    }

    mybox = Hive.box<Taskmodel>(Constants.boxname);

    setState(() {
      reload();
    });
  }

  @override
  @override
  void initState() {
    super.initState();

    searchBox = Searchbox(
      onchanged: (String query) {
        setState(() {}); // Triggers rebuild when search text changes
      },
    );

    // Open the box and then reload
    openBox();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          const SizedBox(height: 80),
          searchBox,
          const SizedBox(height: 20),
          ToggleRow(
            donepress: () {
              setState(() {
                done = !done;
                undone = false;
              });
            },
            undonepress: () {
              setState(() {
                undone = !undone;
                done = false;
              });
            },
          ),
          Expanded(
              child: ListView.builder(
            itemCount: modelsList.length,
            itemBuilder: (context, index) => buildTask(index),
          )),
        ],
      ),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Add a todo item",
                              style: TextStyle(
                                  color: Colors.deepPurple, fontSize: 20),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    titleController.clear();
                                    subtitleController.clear();
                                  },
                                  child: const Text(
                                    "Cancel",
                                  )),
                              TextButton(
                                  onPressed: () async {
                                    if (titleController.text == "") {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: const Text(
                                                  "Title can't be empty"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "OK",
                                                    )),
                                              ],
                                            );
                                          });
                                    } else {
                                      Taskmodel newmodel = Taskmodel(
                                          title: titleController.text,
                                          subTitle: subtitleController.text);
                                      await mybox.add(newmodel);

                                      reload();

                                      Navigator.pop(context);
                                      titleController.clear();
                                      subtitleController.clear();
                                      setState(() {});
                                    }
                                  },
                                  child: const Text("save"))
                            ],
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: titleController,
                                  decoration:
                                      const InputDecoration(hintText: "title"),
                                ),
                                TextField(
                                  controller: subtitleController,
                                  decoration: const InputDecoration(
                                      hintText: "describtion"),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.add, color: Colors.white, size: 30))))
    ]);
  }
}
