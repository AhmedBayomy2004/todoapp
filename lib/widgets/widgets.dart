import 'package:flutter/material.dart';
import 'package:todoapp/models/models.dart';

class Task extends StatelessWidget {
  final Taskmodel model;
  final void Function()? ondelete;
  final void Function()? oncheck;

  Task({
    super.key,
    required this.model,
    required this.ondelete,
    required this.oncheck,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        "${model.createdAt.day}/${model.createdAt.month}/${model.createdAt.year}";

    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ListTile(
        leading: IconButton(
          onPressed: oncheck,
          icon: Icon(
            model.done ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.deepPurple,
          ),
        ),
        title: Text(
          model.title,
          style: TextStyle(
            decoration: model.done ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(model.subTitle),
            const SizedBox(height: 4),
            Text(
              "Added: $formattedDate",
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: ondelete,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}

class Searchbox extends StatelessWidget {
  Searchbox({super.key, required this.onchanged});
  final void Function(String)? onchanged;
  final TextEditingController fieldController = TextEditingController();
  TextEditingController getController() {
    return fieldController;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: TextField(
          controller: fieldController,
          onChanged: onchanged,
          decoration: const InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderSide: BorderSide.none)),
        ));
  }
}

class ToggleRow extends StatefulWidget {
  const ToggleRow(
      {super.key, required this.donepress, required this.undonepress});
  final void Function()? donepress;
  final void Function()? undonepress;

  @override
  State<ToggleRow> createState() => _ToggleRowState();
}

class _ToggleRowState extends State<ToggleRow> {
  bool firstpressed = false;
  bool secondpressed = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            onPressed: () {
              firstpressed = !firstpressed;
              secondpressed = false;
              widget.donepress!();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: firstpressed
                  ? Colors.deepPurple
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              foregroundColor: firstpressed ? Colors.white : Colors.deepPurple,
              elevation: firstpressed ? 1 : 6,
              shadowColor: Colors.black,
            ),
            child: const Text("Done")),
        ElevatedButton(
            onPressed: () {
              secondpressed = !secondpressed;
              firstpressed = false;
              widget.undonepress!();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: secondpressed
                  ? Colors.deepPurple
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              foregroundColor: secondpressed ? Colors.white : Colors.deepPurple,
              elevation: secondpressed ? 1 : 6,
              shadowColor: Colors.black,
            ),
            child: const Text("Undone"))
      ],
    );
  }
}
