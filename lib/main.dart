import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CubePage(),
    ),
  );
}

const widthAndHeight = 100.0;

class CubePage extends StatefulWidget {
  const CubePage({super.key});

  @override
  State<CubePage> createState() => _CubePageState();
}

class _CubePageState extends State<CubePage> with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    _xController = AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _yController = AnimationController(vsync: this, duration: const Duration(seconds: 30));
    _zController = AnimationController(vsync: this, duration: const Duration(seconds: 40));
    _animation = Tween<double>(
      begin: 0,
      end: pi * 2,
    );
    super.initState();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 100,
            width: double.infinity,
          ),
          AnimatedBuilder(
            animation: Listenable.merge([
              _xController,
              _yController,
              _zController,
            ]),
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_animation.evaluate(_xController))
                  ..rotateY(_animation.evaluate(_yController))
                  ..rotateZ(_animation.evaluate(_zController)),
                child: Stack(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..translate(Vector3(0, 0, -widthAndHeight)),
                      child: Container(
                        color: Colors.pink,
                        height: widthAndHeight,
                        width: widthAndHeight,
                      ),
                    ),
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        color: Colors.red,
                        height: widthAndHeight,
                        width: widthAndHeight,
                      ),
                    ),
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()..rotateY(-pi / 2),
                      child: Container(
                        color: Colors.blue,
                        height: widthAndHeight,
                        width: widthAndHeight,
                      ),
                    ),
                    Container(
                      color: Colors.green,
                      height: widthAndHeight,
                      width: widthAndHeight,
                    ),
                    Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()..rotateX(-pi / 2),
                      child: Container(
                        color: Colors.orange,
                        height: widthAndHeight,
                        width: widthAndHeight,
                      ),
                    ),
                    Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()..rotateX(pi / 2),
                      child: Container(
                        color: Colors.brown,
                        height: widthAndHeight,
                        width: widthAndHeight,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
