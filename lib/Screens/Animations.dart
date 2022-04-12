import 'package:flutter/material.dart';

enum ListAnimState { slide, fade, rotation, size, combined, initial }

class Animations extends StatefulWidget {
  static const routeName = "/Animations";
  const Animations({Key? key}) : super(key: key);

  @override
  State<Animations> createState() => _AnimationsState();
}

class _AnimationsState extends State<Animations> with TickerProviderStateMixin {
  //access animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  late AnimationController _animatedIconController;
  late AnimationController _loadingAnimController;//?????
  bool animatedIconTriggred = false;
  ListAnimState listAnimState = ListAnimState.slide;
  List<int> _items = [];

  ///load initail list items with animations
  _loadItems() {
    listAnimState = ListAnimState.initial;
    //a future var instance
    var future = Future(() {});
    //get data from dataBase
    for (var i = 0; i < 5; i++) {
      //when the previews future done, do next
      future = future.then(
        (value) => Future.delayed(
          const Duration(milliseconds: 100),
          () {
            listKey.currentState!.insertItem(i);
            _items.add(i);
          },
        ),
      );
    }
  }

  @override
  void initState() {
    _animatedIconController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _loadingAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _loadingAnimController.forward();
    _loadItems();
    super.initState();
  }

  @override
  void dispose() {
    _animatedIconController.dispose();
    _items.clear();
    super.dispose();
  }

  Widget slideIt(BuildContext context, int index, animation) {
    Widget listItem = SizedBox(
      // Actual widget to display
      height: 50,
      child: Card(
        //a rondom color
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(
          child: Text('Item ${index + 1}'),
        ),
      ),
    );
    //custom animation for each button
    switch (listAnimState) {

      //slive animation
      case ListAnimState.slide:
        return SlideTransition(
          //inset to screen
          position: Tween<Offset>(
            //from left
            begin: const Offset(-1, 0),
            //to screen
            end: const Offset(0, 0),
          ).animate(animation),
          child: listItem,
        );

      //fade animation
      case ListAnimState.fade:
        return FadeTransition(
          opacity: animation,
          child: listItem,
        );

      //rotation animation
      case ListAnimState.rotation:
        return RotationTransition(
          turns: animation,
          child: listItem,
        );

      //size animation
      case ListAnimState.size:
        return SizeTransition(
          sizeFactor: animation,
          child: listItem,
        );

      case ListAnimState.combined:
        return SlideTransition(
          //inset to screen
          position: Tween<Offset>(
            //from left
            begin: const Offset(0, 1),
            //to screen
            end: const Offset(0, 0),
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: listItem,
            ),
          ),
        );

      //size animation
      case ListAnimState.initial:
        return SlideTransition(
          position: Tween<Offset>(
            //from left
            begin: const Offset(0, 1),
            //to screen
            end: const Offset(0, 0),
          ).animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: listItem,
          ),
        );

      default:
        return SizeTransition(
          sizeFactor: animation,
          child: listItem,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //a list with animations
          AnimatedList(
            key: listKey,
            itemBuilder: slideIt,
            shrinkWrap: true,
            initialItemCount: _items.length,
          ),
          //button for each animation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //fade
              ElevatedButton(
                onPressed: () {
                  listAnimState = ListAnimState.fade;
                  listKey.currentState!.insertItem(_items.length,
                      duration: const Duration(milliseconds: 500));
                  _items.add(_items.length + 1);
                },
                child: Text("fade"),
              ),

              //rotation
              AnimatedOpacity(
                opacity: 1,
                duration: const Duration(seconds: 2),
                child: ElevatedButton(
                  onPressed: () {
                    listAnimState = ListAnimState.rotation;
                    listKey.currentState!.insertItem(_items.length,
                        duration: const Duration(milliseconds: 500));
                    _items.add(_items.length + 1);
                  },
                  child: Text("rotation"),
                ),
              ),

              // slide
              ElevatedButton(
                onPressed: () {
                  listAnimState = ListAnimState.slide;
                  listKey.currentState!.insertItem(_items.length,
                      duration: const Duration(milliseconds: 500));
                  _items.add(_items.length + 1);
                },
                child: Text("slide"),
              ),

              //size
              ElevatedButton(
                onPressed: () {
                  listAnimState = ListAnimState.size;
                  listKey.currentState!.insertItem(0,
                      duration: const Duration(milliseconds: 500));
                  _items.add(_items.length + 1);
                },
                child: Text("size"),
              ),

              //combined
              ElevatedButton(
                onPressed: () {
                  listAnimState = ListAnimState.combined;
                  listKey.currentState!.insertItem(0,
                      duration: const Duration(milliseconds: 500));
                  _items.add(_items.length + 1);
                },
                child: Text("combined"),
              ),
            ],
          )
        ],
      ),
      //for icon and hero animations
      floatingActionButton: FloatingActionButton(
        //hero animation
        heroTag: "hero",
        onPressed: () {
          //trigger icon animation
          if (!animatedIconTriggred) {
            _animatedIconController.forward();
            animatedIconTriggred = true;
          } else {
            _animatedIconController.reverse();
            animatedIconTriggred = false;
          }
          if (_items.isNotEmpty) {
            listAnimState = ListAnimState.fade;
            listKey.currentState!.removeItem(
                0, (context, animation) => Container(),
                duration: const Duration(milliseconds: 500));
            _items.removeAt(0);
          }
        },
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animatedIconController,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
