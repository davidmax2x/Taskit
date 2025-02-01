import 'package:flutter/material.dart';
import 'package:taskit/Components/NoteTextField.dart';

class EditNootes extends StatelessWidget {
  const EditNootes({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          onPressed: () {
            Navigator.pop(context);
            
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(),
        body: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const NoteTextField(
                  hintText: 'Title',
                ),
                const SizedBox(
                  height: 10,
                ),
                const NoteTextField(
                  hintText: 'Course Code',
                ),
                const SizedBox(
                  height: 5,
                ),
                // course code history
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Course Code History',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    maxLines: null,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Enter your notes here',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
