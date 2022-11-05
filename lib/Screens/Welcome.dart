import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobology/Widgets/Welcome.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcome extends StatefulWidget {
  Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final controller = LiquidController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(alignment: Alignment.center, children: [
      LiquidSwipe(
        pages: [
          Container(
              padding: const EdgeInsets.all(30),
              color: Colors.blue.shade200,
              child: Welcome_widget(
                height: height,
                title: "this is title",
                Subtitle: "this is Sub title",
                img_url: "images/ltuc.jpg",
                num: "1/3",
              )),
          Container(
            color: Color((0xfffddcdf)),
            child: Welcome_widget(
              height: height,
              title: "this is title",
              Subtitle: "this is Sub title",
              img_url: "images/ltuc.png",
              num: "2/3",
            ),
          ),
          Container(
            color: Color(0xffffdcbd),
            child: Welcome_widget(
              height: height,
              title: "this is title",
              Subtitle: "this is Sub title",
              img_url: "images/js.webp",
              num: "3/3",
            ),
          ),
        ],
        slideIconWidget: const Icon(Icons.arrow_back_ios),
        enableSideReveal: true,
        liquidController: controller,
        onPageChangeCallback: onPageChangedCallback,
      ),
      Positioned(
        bottom: 60.0,
        child: OutlinedButton(
          onPressed: () {
            int nextPage = controller.currentPage + 1;
            controller.animateToPage(page: nextPage);
          },
          style: ElevatedButton.styleFrom(
            side: const BorderSide(color: Colors.black26),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            onPrimary: Colors.white,
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
                color: Color(0xff272727), shape: BoxShape.circle),
            child: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ),
      Positioned(
        top: 50,
        right: 20,
        child: TextButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, "Home");
          },
          child: const Text("Skip"),
        ),
      ),
      Positioned(
        bottom: 10,
        child: AnimatedSmoothIndicator(
          count: 3,
          activeIndex: controller.currentPage,
          effect: const WormEffect(
            activeDotColor: Color(0xff272727),
            dotHeight: 5.0,
          ),
        ),
      ),
    ]));
  }

  onPageChangedCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }
}
