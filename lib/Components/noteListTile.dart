import 'package:flutter/material.dart';

class NoteListTile extends StatelessWidget {
  const NoteListTile({
    super.key,
    required this.title,
    required this.courseCode,
    required this.time,
  });
  final String title;
  final String courseCode;
  final DateTime time;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      color: Theme.of(context).colorScheme.secondary,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseCode,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  time.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          // Handle note tap
        },
      ),
    );
  }
}
