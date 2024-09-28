import 'dart:math';

import 'package:flutter/material.dart';

import '../models/movie_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController controller;

  int currentIndex = 1;

  double pageoffSet = 1;

  ///
  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: 1,
      viewportFraction: 0.6,
    )..addListener(() => setState(() => pageoffSet = controller.page!));
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  /////

                  PageView.builder(
                    controller: controller,
                    onPageChanged: (index) =>
                        setState(() => currentIndex = index % movies.length),
                    itemBuilder: (context, index) {
                      double scale = max(
                        0.6,
                        (1 - (pageoffSet - index).abs() + 0.6),
                      );

                      double angle = (controller.position.haveDimensions
                              ? index.toDouble() - (controller.page ?? 0)
                              : index.toDouble() - 1) *
                          5;

                      angle = angle.clamp(-5, 5);

                      final movie = movies[index % movies.length];

                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding:
                              EdgeInsets.only(top: 100 - (scale / 1.6 * 100)),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Transform.rotate(
                                angle: angle * pi / 90,
                                child: Hero(
                                  tag: movie.poster,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      movie.poster,
                                      height: 300,
                                      width: 205,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  /////

                  Positioned(
                    top: 330,
                    child: Row(
                      children: List.generate(
                        movies.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 15),
                          width: currentIndex == index ? 30 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? Colors.yellowAccent
                                : Colors.white24,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /////
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
