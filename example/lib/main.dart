import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_lottie/flutter_lottie.dart';
import 'page_dragger.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [DefaultMaterialLocalizations.delegate],
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  LottieController controller2;

  StreamController<double> newProgressStream;

  _PageState() {
    newProgressStream = new StreamController<double>();
  }

  @override
  Widget build(BuildContext context) {
    return PageDragger(
      stream: this.newProgressStream,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lottie'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Text("Play"),
                onPressed: () {
                  controller2.play();
                },
              ),
              FlatButton(
                child: Text("Stop"),
                onPressed: () {
                  controller2.stop();
                },
              ),
              FlatButton(
                child: Text("Pause"),
                onPressed: () {
                  controller2.pause();
                },
              ),
              FlatButton(
                child: Text("Resume"),
                onPressed: () {
                  controller2.resume();
                },
              ),
              new Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: LottieView.fromFile(
                    filePath: "animations/newAnimation.json",
                    autoPlay: true,
                    loop: true,
                    reverse: true,
                    onViewCreated: onViewCreatedFile,
                  ),
                ),
              ),
              FlatButton(
                child: Text("Change Color"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Scaffold(
                          backgroundColor: Colors.transparent,
                          body: new Center(
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: LottieView.fromFile(
                                filePath: "animations/newAnimation.json",
                                autoPlay: true,
                                loop: true,
                                reverse: true,
                                //onViewCreated: onViewCreatedFile,
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
              Text("Drag anywhere to change animation progress"),
            ],
          ),
        ),
      ),
    );
  }

  void onViewCreatedFile(LottieController controller) {
    this.controller2 = controller;
    newProgressStream.stream.listen((double progress) {
      this.controller2.setAnimationProgress(progress);
    });
  }

  void dispose() {
    super.dispose();
    newProgressStream.close();
  }
}
