import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../data/constants/constants.dart';
import '../utils/page.dart';
import '../utils/utils.dart';
import '../widgets/album_card.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/painter.dart';

class Discover extends ConsumerStatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  ConsumerState<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends ConsumerState<Discover> {
  final tabs = ['Film Score', 'Music Theatre', 'Video Game Music', 'Stream'];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < Constants.albumList.length; ++i) {
      ExactAssetImage(Constants.albumList[i].image!);
    }
    // Check and request for permission.
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : null;
  }

  @override
  void didChangeDependencies() {
    for (var i = 0; i < Constants.albumList.length; ++i) {
      precacheImage(Utils.buildExactAssetImage(i), context);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: Utils.buildGradient()),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            title: Text('Discover', style: TextStyle(fontSize: 32, color: Colors.white.withOpacity(0.9))),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(CupertinoIcons.search, color: Colors.white.withOpacity(0.7)),
              ),
            ],
            backgroundColor: Colors.transparent,
            bottom: TabBar(
              isScrollable: true,
              indicator: UnderlineTabIndicator(
                insets: const EdgeInsets.symmetric(horizontal: -8, vertical: 1),
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Color(0xfffcc8c0), width: 2),
              ),
              dividerColor: Colors.white.withOpacity(0.2),
              labelColor: Colors.white,
              splashFactory: NoSplash.splashFactory,
              labelStyle: const TextStyle(fontSize: 17),
              unselectedLabelColor: Colors.white.withOpacity(0.5),
              tabs: tabs.map((e) => Tab(text: e, height: 25)).toList(),
            ),
          ),
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(children: [
                    10.spaceY(),

                    /// Row 2 --- Big Carousel Slider
                    Card(
                      elevation: 5,
                      shadowColor: const Color(0xff866684),
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Container(
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(fit: BoxFit.cover, image: ExactAssetImage(Constants.album)),
                        ),
                      ),
                    ),
                    20.spaceY(),

                    /// Row 4 --- New Albums
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: CustomPaint(painter: Line()),
                          ),
                          10.spaceX(),
                          const Text('New Albums', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                        ],
                      ),
                      Icon(CupertinoIcons.forward, color: Colors.white.withOpacity(0.6))
                    ]),

                    15.spaceY(),

                    /// Horizontal List
                    158.spaceY(
                      ListView.builder(
                        shrinkWrap: true,
                        itemExtent: 115,
                        itemCount: Constants.albumList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return AlbumCard(index: index, ref: ref);
                        },
                      ),
                    ),

                    30.spaceY(),

                    ///Row 5 --- Collection of Artist
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: CustomPaint(painter: Line()),
                          ),
                          10.spaceX(),
                          const Text('Recommended Playlist', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal)),
                        ],
                      ),
                      Icon(CupertinoIcons.forward, color: Colors.white.withOpacity(0.6))
                    ]),

                    20.spaceY(),

                    155.spaceY(
                      !_hasPermission
                          ? noAccessToLibraryWidget()
                          : FutureBuilder<List<SongModel>>(
                              // Default values:
                              future: _audioQuery.querySongs(
                                sortType: null,
                                orderType: OrderType.ASC_OR_SMALLER,
                                uriType: UriType.EXTERNAL,
                                ignoreCase: true,
                              ),
                              builder: (context, item) {
                                // Display error, if any.
                                if (item.hasError) {
                                  return Text(item.error.toString());
                                }

                                // Waiting content.
                                if (item.data == null) {
                                  return const CircularProgressIndicator();
                                }

                                // 'Library' is empty.
                                if (item.data!.isEmpty) return const Text("Nothing found!");

                                // You can use [item.data!] direct or you can create a:
                                // List<SongModel> songs = item.data!;
                                return ListView.builder(
                                  itemCount: item.data!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(item.data![index].title),
                                      subtitle: Text(item.data![index].artist ?? "No Artist"),
                                      trailing: const Icon(Icons.arrow_forward_rounded),
                                      // This Widget will query/load image.
                                      // You can use/create your own widget/method using [queryArtwork].
                                      leading: QueryArtworkWidget(
                                        controller: _audioQuery,
                                        id: item.data![index].id,
                                        type: ArtworkType.AUDIO,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),

                    20.spaceY(),

                    /// Horizontal List
                    155.spaceY(
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: Constants.artisteList.length,
                        itemBuilder: (_, index) {
                          return buildArtists(index);
                        },
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNav(context: context, ref: ref, page: NavPage.discover),
        ),
      ),
    );
  }

  Widget buildArtists(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          elevation: 2,
          shadowColor: const Color(0xff866684),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black45,
              image: DecorationImage(image: ExactAssetImage(Constants.albumList[index].image!), fit: BoxFit.cover),
            ),
          ),
        ),
        10.spaceX(),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          235.spaceX(Text(
              overflow: TextOverflow.ellipsis, Constants.albumList[index].title!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white.withAlpha(190)))),
          5.spaceY(),
          Text(Constants.albumList[index].artiste!.name, style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(150))),
        ]),
      ],
    );
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}

