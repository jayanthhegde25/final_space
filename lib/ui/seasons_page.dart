import 'package:flutter/material.dart';

class SeasonsPage extends StatefulWidget {
  const SeasonsPage({super.key});

  @override
  State<SeasonsPage> createState() => _SeasonsPageState();
}

class _SeasonsPageState extends State<SeasonsPage> {
  final List<String> items = List<String>.generate(10, (index) => "Item $index");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blue,
            child: Center(
              child: Text(
                items[index],
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
