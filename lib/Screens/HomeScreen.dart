import 'package:flutter/material.dart';
import 'package:uisamples/Helpers/custom_route.dart';
import 'package:uisamples/Screens/Animations.dart';
import 'package:uisamples/Screens/Buttons.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      //this container hold the entire body
      body: Container(
        constraints: const BoxConstraints.expand(),
        //list of buttons
        child: Column(
          //items get max width
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .push(SlideRoute(builder: (_) => Buttons())),
              child: const Text("Buttons"),
            ),
            Hero(
              tag: "hero",
              child: ElevatedButton(
                onPressed: () => Navigator.of(context)
                    .push(FadeRoute(builder: (_) => Animations())),
                child: const Text("Animations"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
