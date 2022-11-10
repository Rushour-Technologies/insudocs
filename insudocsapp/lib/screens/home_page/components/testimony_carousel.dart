import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:insudox_app/screens/home_page/components/testimony_cards.dart';

class TestimonyCarouselSlider extends StatefulWidget {
  const TestimonyCarouselSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<TestimonyCarouselSlider> createState() =>
      _TestimonyCarouselSliderState();
}

class _TestimonyCarouselSliderState extends State<TestimonyCarouselSlider> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height
    ];
    final double screenHeight = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[0]
        : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[1]
        : tempDimensions[0];

    List<Map<String, dynamic>> testimonyData = [
      {
        "name": "Vinita",
        "role": "User",
        "testimony":
            "Insudox is very easy to use. It's a great way to track of all your policy claims. The 'saviors' are indeed the most certified and helpful people I needed through my difficult times. Thanks to Insudox, my life is a lot easier right now. My claim settlement was super easy. Called the team and they got my back without any hassle. The team was very cooperative, they listen to your doubts suggest and update you with the right things. Would definitely recommend Insudox for claiming insurance.",
      },
      {
        "name": "Bhavesh",
        "role": "User",
        "testimony":
            "Insudox is extremely simple to utilize. It's an extraordinary method for following of all your strategy claims. The 'savior' are without a doubt the most ensured and supportive individuals I wanted through my troublesome times. Because of Insudox, my life is significantly simpler at the present time. My case settlement was really simple. Called the group and they got me covered with no problem. The group was extremely agreeable, they pay attention to your questions recommend and refresh you with the right things. Would suggest Insudox for asserting protection.",
      },
      {
        "name": "John",
        "role": "User",
        "testimony":
            "Insudox has a very phenomenal technique for following all your procedure claims. The 'saviors' are definitely the most trusted and steady people I needed through my problematic times. Due to Insudox, my life is fundamentally less difficult right now. My case settlement was truly simple through the app. Contacting different people for my claim was easy and they got my paperwork covered with no issue. The meetings were incredibly straightforward, they focus on your inquiries suggest and revive your claim with the right things. Would recommend Insudox for attesting assurance in this field.",
      },
    ];

    return Column(children: [
      CarouselSlider.builder(
        carouselController: _carouselController,
        itemCount: 3,
        itemBuilder: (context, index, realIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth / 30),
            child: TestimonyCard(
              name: testimonyData[index]["name"],
              role: testimonyData[index]["role"],
              testimony: testimonyData[index]["testimony"],
              index: index,
            ),
          );
        },
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          aspectRatio: 0.7,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          onPageChanged: (index, reason) {
            _currentIndex = index;
            setState(() {});
          },
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [1, 2, 3].asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _carouselController.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
