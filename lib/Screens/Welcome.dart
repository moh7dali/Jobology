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
                title: "Find a Job Easily !",
                Subtitle:
                    "Choose a job you love, and you will never have to work a day in your life",
                img_url: "images/job.png",
                num: "1/4",
              )),
          Container(
            color: Color((0xfffddcdf)),
            child: Welcome_widget(
              height: height,
              title: "Discover a new Courses",
              Subtitle: "Learning never exhausts the mind",
              img_url: "images/Courses.png",
              num: "2/4",
            ),
          ),
          Container(
            color: Color(0xffffdcbd),
            child: Welcome_widget(
              height: height,
              title: "Start build your cv",
              Subtitle: "Your cv is just a commodity, package yourself",
              img_url: "images/cv.png",
              num: "3/4",
            ),
          ),
          Container(
            color: Color(0xFFBEF988),
            child: Welcome_widget(
              height: height,
              title: "Interview Questions",
              Subtitle: "Opportunities don't happen, you create them",
              img_url: "images/interview.png",
              num: "4/4",
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
            if (nextPage == 4) {
              Navigator.popAndPushNamed(context, "Login");
            }
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
            Navigator.popAndPushNamed(context, "Login");
          },
          child: Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 202, 202, 202)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ),
      ),
      Positioned(
        bottom: 10,
        child: AnimatedSmoothIndicator(
          count: 4,
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
