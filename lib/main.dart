import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey key = GlobalKey();
  Offset? myOffset;
  OverlayEntry? resultDisplay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MouseRegion(
                  onEnter: (val) {
                    debugPrint("onEnter Called");
                    RenderBox box =
                        key.currentContext?.findRenderObject() as RenderBox;
                    Offset position = box
                        .localToGlobal(Offset.zero); //this is global position
                    resultDisplay = OverlayEntry(
                        builder: (context) => Positioned(
                              top: position.dy + 50.0,
                              left: position.dx,
                              child: Container(
                                  height: 200.0,
                                  width: 200.0,
                                  color: Colors.yellow),
                            ));
                    Overlay.of(context)?.insert(resultDisplay!);
                  },
                  onExit: (val) {
                    if (resultDisplay != null) {
                      resultDisplay!.remove();
                      resultDisplay = null;
                    }
                  },
                  // onHover: (_) {
                  //   debugPrint("onHover Called");
                  // },
                  child: Container(
                      key: key,
                      height: 50.0,
                      width: 200.0,
                      color: Colors.purple)),
              /*SizedBox(
                key: key,
                height: 50.0,
                width: 200.0,
                child: OnHover(builder: (isHover) {
                  if (isHover) {
                    debugPrint("isHover is true");
                    RenderBox box =
                        key.currentContext?.findRenderObject() as RenderBox;
                    myOffset = box.localToGlobal(Offset.zero);
                    setState(() {});
                  } else {
                    debugPrint("isHover is false");
                  }
                  return Container(color: Colors.purple);
                }),
              ),*/
              const SizedBox(width: 20.0),
              Container(height: 50.0, width: 200.0, color: Colors.orange),
            ],
          ),
        ),
        if (myOffset != null)
          Positioned(
            top: myOffset!.dy,
            left: myOffset!.dx,
            child: Container(height: 200.0, width: 200.0, color: Colors.red),
          )
      ]),
    );
  }
}

class OnHover extends StatefulWidget {
  final Widget Function(bool isHovered) builder;

  const OnHover({Key? key, required this.builder}) : super(key: key);

  @override
  _OnHoverState createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => onEntered(true),
      onExit: (_) => onEntered(false),
      child: widget.builder(isHovered),
    );
  }

  //used to set bool isHovered to true/false
  void onEntered(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }
}
