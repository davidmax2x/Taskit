import 'package:flutter/material.dart';

class Note_view extends StatefulWidget {
  const Note_view({Key? key}) : super(key: key);

  @override
  State<Note_view> createState() => _Note_viewState();
}

class _Note_viewState extends State<Note_view> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              const ListTile(
                contentPadding: EdgeInsets.all(10),
              );
              return null;
            })
      ],
    );
  }
}
