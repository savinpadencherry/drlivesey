// ignore_for_file: public_member_api_docs, sort_constructors_first
part of home_view;

class _HomeMobile extends StatefulWidget {
  const _HomeMobile();

  @override
  State<_HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<_HomeMobile>
    with LogMixin, TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late PageController pageController;
  late VideoPlayerController _controller;
  String description = 'DR Livesey the ultimate giga chad and his walk';
  late AnimationController _animationcontroller;
  late Animation<Offset> animation;
  List<CarouselWidgetImage> mediaWidgets = [];
  List<MediaFiles> mediaModelsFiles = [];
  getMediaData() async {
    List<CarouselWidgetImage> mediaWidgetsGet =
        await getIt<DataRepository>().getVideoData();
    setState(() {
      mediaWidgets = mediaWidgetsGet;
    });
    warningLog('$mediaWidgets');
  }

  getMediaModels() async {
    List<MediaFiles> mediaModels =
        await getIt<DataRepository>().getVideoDataModels();
    setState(() {
      mediaModelsFiles = mediaModels;
    });
    warningLog('$mediaModelsFiles');
  }

  @override
  void initState() {
    getMediaData();
    // getMediaModels();
    // _controller = VideoPlayerController.asset('assets/drlivesey.mp4')
    //   ..initialize().then((value) {
    //     setState(() {});
    //   });
    pageController = PageController(viewportFraction: 0.8);
    _animationcontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation =
        Tween<Offset>(begin: const Offset(0, -1.5), end: const Offset(0, 1))
            .animate(CurvedAnimation(
                parent: _animationcontroller, curve: Curves.bounceInOut));
    // _controller.play();
    // _controller.setLooping(true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('Make it personal'),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: mediaWidgets,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SafeArea firstmethod() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CupertinoColors.systemBackground,
        body: RefreshIndicator(
          onRefresh: () => getMediaData(),
          child: Column(
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
              Column(
                children: mediaWidgets,
              ),
              // CarouselSlider(
              //   //  carouselController: ,
              //   items: mediaWidgets,
              //   // [
              //   // SingleChildScrollView(
              //   //   child: Column(
              //   //     children: [
              //   //       Container(
              //   //         height: 600,
              //   //         width: 250,
              //   //         decoration: BoxDecoration(
              //   //             color: Colors.grey,
              //   //             borderRadius: BorderRadius.circular(15.0),
              //   //             boxShadow: const [
              //   //               BoxShadow(
              //   //                 color: Colors.grey,
              //   //                 offset: Offset(0, 2),
              //   //                 spreadRadius: 1,
              //   //                 blurRadius: 15,
              //   //               )
              //   //             ]),
              //   //         child: ClipRRect(
              //   //           borderRadius: BorderRadius.circular(15.0),
              //   //           child: VideoPlayer(_controller),
              //   //         ),
              //   //       ),
              //   //       const SizedBox(
              //   //         height: 30,
              //   //       ),
              //   //       Text(description)
              //   //     ],
              //   //   ),
              //   // ),
              //   // GestureDetector(
              //   //   onTap: () => getIt<DataRepository>().,
              //   //   child: CarouselWidgetImage(
              //   //     imageUrl:
              //   //         'https://static.wikia.nocookie.net/sexypedia/images/b/bf/Dr._Livesey.jpg/revision/latest/scale-to-width-down/350?cb=20220816152727',
              //   //   ),
              //   // ),
              //   // CarouselWidgetImage(
              //   //   imageUrl:
              //   //       'https://i.scdn.co/image/ab67616d0000b2738fbb15d6de507f92e18b8ca4',
              //   // ),
              //   // CarouselWidgetImage(
              //   //   imageUrl:
              //   //       'https://www.meme-arsenal.com/memes/d4ba6523f554a7ad02ce99d8c1003dc9.jpg',
              //   // ),
              //   //    ],
              //   options: CarouselOptions(
              //     height: 400,
              //     aspectRatio: 16 / 9,
              //     viewportFraction: 0.6,
              //     initialPage: 0,
              //     enableInfiniteScroll: false,
              //     reverse: false,
              //     autoPlay: false,
              //     autoPlayInterval: const Duration(seconds: 3),
              //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
              //     autoPlayCurve: Curves.fastOutSlowIn,
              //     enlargeCenterPage: true,
              //     onPageChanged: (pageno, pagechangedreason) {
              //       warningLog('$pagechangedreason, $pageno');
              //       if (pageno == 0) {
              //         // _controller.play();
              //         _animationcontroller.forward();
              //         setState(() {
              //           description =
              //               'DR Livesey the ultimate giga chad and his walk';
              //         });
              //       } else if (pageno == 1) {
              //         _animationcontroller.forward();
              //         setState(() {
              //           description =
              //               'Dr livesey warns you like the giga chad he is lol';
              //           warningLog('${description.length}');
              //         });
              //         // _controller.pause();
              //       } else if (pageno == 2) {
              //         _animationcontroller.forward();
              //         setState(() {
              //           description =
              //               'Dr livesey being wholesome while fighting terrorists';
              //           warningLog('${description.length}');
              //         });
              //         // _controller.pause();
              //       } else if (pageno == 3) {
              //         _animationcontroller.forward();
              //         setState(() {
              //           description =
              //               'Please introduce yourself to Dr livesey normie';
              //           warningLog('${description.length}');
              //         });
              //         // _controller.pause();
              //       }
              //     },
              //     scrollDirection: Axis.horizontal,
              //   ),
              // ),
              const SizedBox(
                height: 60,
              ),
              SlideTransition(
                position: animation,
                child: Text(description),
              )
            ],
          ),
        ),
      ),
    );
  }
}
