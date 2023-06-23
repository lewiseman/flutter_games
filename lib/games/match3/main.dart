import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_games/games/match3/game.dart';
import 'package:flutter_games/games/match3/models/level.dart';

// https://medium.com/flutter-community/flutter-crush-debee5f389c3
void main() {
  runApp(const Match3Game());
}

class Match3Game extends StatelessWidget {
  const Match3Game({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return const MaterialApp(
      title: 'Match 3',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final contentPadding = screenSize.width * .1;
    return Material(
      color: const Color.fromARGB(255, 211, 253, 228),
      child: Stack(
        children: [
          ...background(screenSize),
          Positioned(
            left: contentPadding,
            right: contentPadding,
            top: 200,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 18,
              children: levels
                  .map(
                    (e) => InkWell(
                      onTap: () => Game.push(context, e),
                      child: Container(
                        padding: const EdgeInsets.all(40),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/match3/images/btn.png'),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(-2, 1),
                              spreadRadius: -3,
                              blurRadius: 31,
                              color: Color.fromRGBO(0, 0, 0, 0.146),
                            )
                          ],
                        ),
                        child: Text(
                          e.index.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList()
                  .animate(interval: 200.ms)
                  .fade()
                  .slideX(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> background(Size screenSize) {
    final isLandscape = screenSize.height < screenSize.width;
    // calculate best postion for image on mobile devices , to avaid clutter at the center
    final imgBgPos = isLandscape
        ? 0.0
        : ((screenSize.height * .3) - (screenSize.width * .3)) * -1;
    return [
      Positioned(
        left: imgBgPos,
        child: Image.asset(
          'assets/match3/images/bg_left.png',
          height: screenSize.height,
          fit: BoxFit.fitHeight,
        )
            .animate()
            .slideX(duration: const Duration(milliseconds: 600))
            .fadeIn(delay: const Duration(milliseconds: 300)),
      ),
      Positioned(
        right: imgBgPos,
        child: Image.asset(
          'assets/match3/images/bg_right.png',
          height: screenSize.height,
          fit: BoxFit.fitHeight,
        )
            .animate()
            .scaleX(duration: const Duration(milliseconds: 600))
            .fadeIn(delay: const Duration(milliseconds: 300)),
      ),
      Positioned(
        left: 0,
        right: 0,
        top: 32,
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/match3/images/logo.png',
                height: 100,
              ),
              const Text(
                'GAME',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  fontSize: 18,
                ),
              )
            ],
          )
              .animate()
              .slideY(begin: 1, end: .1)
              .fadeIn(delay: const Duration(milliseconds: 100)),
        ),
      ),
    ];
  }
}
