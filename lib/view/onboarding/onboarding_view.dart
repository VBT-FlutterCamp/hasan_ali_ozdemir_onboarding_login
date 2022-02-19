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
  final int _flexMinValue = 1;

  late Animation _tweenAnimation;
  late AnimationController _fadeController;  

  @override
  void initState() {
    _fadeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _tweenAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeController);
    _fadeController.forward();
    super.initState();
  }

  @override
  void dispose() { 
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: PageView.builder(itemBuilder: (context, index) {
      return Stack(
        children: [
          _buildImageColumn(_tweenAnimation),
          _buildStepsColumn(_tweenAnimation, _fadeController)
        ],
      );
    }));
  }

  Column _buildStepsColumn(animation, controller) {
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
                  Spacer(
                    flex: _flexMinValue,
                  ),
                  Expanded(flex: _flexMinValue, child: _buildCircles()),
                  Spacer(
                    flex: _flexMinValue,
                  ),
                  Expanded(
                    child: _buildTitle(animation),
                  ),
                  Spacer(
                    flex: _flexMinValue,
                  ),
                  Expanded(
                    flex: 3,
                    child: _buildDesc(animation),
                  ),
                  Spacer(
                    flex: _flexMinValue,
                  ),
                  Expanded(flex: 2, child: _buildButtons(controller)),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ))
      ],
    );
  }

  FadeTransition _buildDesc(animation) {
    return FadeTransition(
      opacity: animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Text(
              onboardingDescList[_currentIndex],
              textAlign: TextAlign.center,
              maxLines: 3,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(height: 2, letterSpacing: 2),
            )
          ],
        ),
      ),
    );
  }

  Row _buildButtons(controller) {
    return Row(
      children: [
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: onPressedSkipButton,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                skip,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white),
              )),
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 3,
          child: InkWell(
            onTap: () => onPressedColoredButton(controller),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.deepPurple),
              child: Center(
                  child: Text(
                (_currentIndex != 2) ? "Continue" : "Finish",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white),
              )),
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        )
      ],
    );
  }

  FadeTransition _buildTitle(animation) => FadeTransition(
      opacity: animation,
      child: FittedBox(
        child: Text(onboardingTitleList[_currentIndex],
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
      ));

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

  onPressedColoredButton(AnimationController controller) async{
    await controller.reverse();
    if (_currentIndex < 2) {
      setState(() {
        _currentIndex++;
      });
      controller.forward();
    } else {
      Navigator.pushNamedAndRemoveUntil(context, "/auth", (route) => false);
    }
  }

  onPressedSkipButton() {
    Navigator.pushNamedAndRemoveUntil(context, "/auth", (route) => false);
  }
}
