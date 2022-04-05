import 'package:flutter/material.dart';
import 'package:flutter_custom_carousel_slider/flutter_custom_carousel_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Custom Carousel Slider Demo'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CarouselItem> itemList = [
    CarouselItem(
      image: const NetworkImage(
        'https://miro.medium.com/max/1400/1*RpaR1pTpRa0PUdNdfv4njA.png',
      ),
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            Colors.blueAccent.withOpacity(1),
            Colors.black.withOpacity(.3),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      title:
          'Push your creativity to its limits by reimagining this classic puzzle!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '\$51,046 in prizes',
      rightSubtitle: '4882 participants',
      rightSubtitleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
      ),
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: const NetworkImage(
        'https://pbs.twimg.com/profile_banners/1444928438331224069/1633448972/600x200',
      ),
      title: '@coskuncay published flutter_custom_carousel_slider!',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '11 Feb 2022',
      rightSubtitle: 'v1.0.0',
      onImageTap: (i) {},
    ),
    CarouselItem(
      image: const ExactAssetImage('assets/justec.jpg'),
      title: 'npx coskuncay',
      titleTextStyle: const TextStyle(
        fontSize: 12,
        color: Colors.white,
      ),
      leftSubtitle: '27 Mar 2022',
      rightSubtitle: 'v1.1.0',
      onImageTap: (i) {},
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  const Text('Custom BoxDecoration and Autoplay'),
                  CustomCarouselSlider(
                    items: itemList,
                    height: 150,
                    subHeight: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    autoplay: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Text(
                      'Show Only Customize Indicators and Bottom Position'),
                  CustomCarouselSlider(
                    items: itemList,
                    height: 150,
                    subHeight: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    autoplay: false,
                    showText: false,
                    showSubBackground: false,
                    indicatorShape: BoxShape.rectangle,
                    indicatorPosition: IndicatorPosition.bottom,
                    selectedDotColor: Colors.red,
                    unselectedDotColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  const Text('Show only images and Autoplay'),
                  CustomCarouselSlider(
                    items: itemList,
                    height: 150,
                    subHeight: 50,
                    width: MediaQuery.of(context).size.width * .9,
                    autoplay: true,
                    showSubBackground: false,
                    indicatorPosition: IndicatorPosition.none,
                    showText: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
