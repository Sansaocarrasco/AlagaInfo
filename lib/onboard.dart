import 'package:flutter/material.dart';
import 'package:onboarding_intro_screen/onboarding_screen.dart';

class Onboarding extends StatefulWidget {
    const Onboarding({Key? key}) : super(key: key);

    @override
        State<Onboarding> createState() => _OnboardingState();
    }

class _OnboardingState extends State<Onboarding> {

    @override
    Widget build(BuildContext context) {
        return OnBoardingScreen(
            onSkip: () {
                debugPrint("On Skip Called....");
            },
            showPrevNextButton: true,
            showIndicator: true,
            backgourndColor: Colors.white,
            activeDotColor: Colors.blue,
            deactiveDotColor: Colors.grey,
            iconColor: Colors.black,
            leftIcon: Icons.arrow_circle_left_rounded,
            rightIcon: Icons.arrow_circle_right_rounded,
            iconSize: 30,
            pages: [
                OnBoardingModel(
                image: Image.asset("assets/images/img1.png"),
                title: "Business Chat",
                body:
                    "First impressions are everything in business, even in chat service. It’s important to show professionalism and courtesy from the start",
                ),
                OnBoardingModel(
                image: Image.asset("assets/images/img3.png"),
                title: "Coffee With Friends",
                body:
                    "When your morning starts with a cup of coffee and you are used to survive the day with the same, then all your Instagram stories and snapchat streaks would stay filled up with coffee pictures",
                ), 
            ],
        );
    }
}
