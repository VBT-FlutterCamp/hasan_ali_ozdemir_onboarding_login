import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onboarding_app/view/onboarding/onboarding_const.dart';

class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    final animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller);

    controller.forward();
    return Scaffold(
        body: Stack(
      children: [_buildImageColumn(animation), _buildStepsColumn(animation)],
    ));
  }

  Column _buildStepsColumn(animation) {
    return Column(
      children: [
        const Spacer(
          flex: topFlex,
        ),
        Expanded(
            flex: bottomFlex,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                  color: Colors.white),
              child: Column(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(flex: 1, child: _buildCircles()),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    child: _buildTitle(animation),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 3,
                    child: FadeTransition(
                      opacity: animation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Wrap(
                          children: [
                            Text(
                              onboardingDescList[_currentIndex],
                              maxLines: 3,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(height: 2,letterSpacing: 2),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [const Spacer(flex: 1,),
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: onPressedColoredButton,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Center(child: Text(skip,
                                style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                          const Spacer(flex: 1,),
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: onPressedColoredButton,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.deepPurple
                                ),
                                child: Center(child: Text((_currentIndex!=2)? "Continue" : "Finish",
                                style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                          const Spacer(flex: 1,)
                        ],
                      )),
                  const Spacer(
                    flex: 2,
                  ),
                  
                ],
              ),
            ))
      ],
    );
  }

  FadeTransition _buildTitle(animation) => FadeTransition(
      opacity: animation,
      child: Text(onboardingTitleList[_currentIndex],
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black)));

  Row _buildCircles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.circle,
              color:
                  (_currentIndex == index) ? Colors.deepPurple : Colors.white,
              size: 18,
            ),
          ),
        );
      }),
    );
  }

  Column _buildImageColumn(animation) {
    return Column(
      children: [
        Expanded(
          flex: topFlex + 1,
          child: FadeTransition(
            opacity: animation,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple,
                        Colors.white,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.01, 1])),
              child: SvgPicture.asset(onboardingAssetList[_currentIndex]),
            ),
          ),
        ),
        const Spacer(
          flex: bottomFlex,
        )
      ],
    );
  }

  onPressedColoredButton() {
    if (_currentIndex <2) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(context, "/auth", (route) => false);
    }
  }

  onPressedSkipButton(){
    Navigator.pushNamedAndRemoveUntil(context, "/auth", (route) => false);
  }
}
