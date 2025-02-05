import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search Notes',
      leading: const Icon(Icons.search),
      padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      backgroundColor:
          WidgetStatePropertyAll(Theme.of(context).colorScheme.tertiary),
      onChanged: (String value) {
        print(value);
      },
    );
  }
}
