import 'package:flutter/material.dart';

class Buttons extends StatefulWidget {
  static const String routeName = "/Buttons";
  const Buttons({Key? key}) : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text("item 1"),
              ),
              const PopupMenuItem(child: Text("item 2")),
              const PopupMenuItem(child: Text("item 3")),
            ],
          ),
        ],
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: ListView(
          itemExtent:50,
          shrinkWrap: true,
          children: [
            //used align to make this exception in size
            Align(
              child: TextButton(
                onPressed: () {},
                child: const Text("TextButton"),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("ElevatedButton"),
            ),
            InkWell(
              onTap: () {},
              child: const Text("InkWell"),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text("ElevatedButton.icon"),
              icon: const Icon(Icons.ac_unit),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text("GestureDetector"),
            ),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {},
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Btn"),
      ),
    );
  }
}
