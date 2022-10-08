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
}
