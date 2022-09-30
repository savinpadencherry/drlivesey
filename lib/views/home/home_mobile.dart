// ignore_for_file: public_member_api_docs, sort_constructors_first
part of home_view;

class _HomeMobile extends StatefulWidget {
  const _HomeMobile();

  @override
  State<_HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<_HomeMobile> with LogMixin {
  late VideoPlayerController _controller;
  String description = 'DR Livesey the ultimate giga chad and his walk';
  @override
  void initState() {
    _controller = VideoPlayerController.asset('assets/drlivesey.mp4')
      ..initialize().then((value) {
        setState(() {});
      });
    _controller.play();
    _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.systemBackground,
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'The First ever Giga Chad',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            CarouselSlider(
              //  carouselController: ,
              items: [
                Container(
                  height: 600,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 2),
                          spreadRadius: 1,
                          blurRadius: 15,
                        )
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: VideoPlayer(_controller),
                  ),
                ),
                const CarouselWidgetImage(
                  imageUrl:
                      'https://static.wikia.nocookie.net/sexypedia/images/b/bf/Dr._Livesey.jpg/revision/latest/scale-to-width-down/350?cb=20220816152727',
                ),
                const CarouselWidgetImage(
                  imageUrl:
                      'https://i.scdn.co/image/ab67616d0000b2738fbb15d6de507f92e18b8ca4',
                ),
                const CarouselWidgetImage(
                  imageUrl:
                      'https://www.meme-arsenal.com/memes/d4ba6523f554a7ad02ce99d8c1003dc9.jpg',
                ),
              ],
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 0.6,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (pageno, pagechangedreason) {
                  warningLog('$pagechangedreason, $pageno');
                  if (pageno == 0) {
                    _controller.play();
                    setState(() {
                      description =
                          'DR Livesey the ultimate giga chad and his walk';
                    });
                  } else if (pageno == 1) {
                    setState(() {
                      description =
                          'Dr livesey warns you like the giga chad he is lol';
                      warningLog('${description.length}');
                    });
                    _controller.pause();
                  } else if (pageno == 2) {
                    setState(() {
                      description =
                          'Dr livesey being wholesome while fighting terrorists';
                      warningLog('${description.length}');
                    });
                    _controller.pause();
                  } else if (pageno == 3) {
                    setState(() {
                      description =
                          'Please introduce yourself to Dr livesey normie';
                      warningLog('${description.length}');
                    });
                    _controller.pause();
                  }
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Text(description)
                  // AnimatedTextKit(
                  //   animatedTexts: [
                  //     TyperAnimatedText(
                  //       description,
                  //     )
                  //   ],
                  // ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
