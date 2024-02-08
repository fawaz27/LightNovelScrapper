import 'package:flutter/material.dart';
import 'package:lnscraper/src/screens/novel.dart';
import 'package:lnscraper/src/utils/screen_sizes.dart';
import 'package:lnscraper/src/widgets/search_widget.dart';
import 'package:lnscraper/src/model/novel.dart';
import 'package:lnscraper/src/widgets/novel_card.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool _isSearchInputVisible = false;
  List<Novel> novels = [
    Novel(
        name: 'Novel 1',
        coverImage: 'assets/images/310s.jpg',
        author: 'None',
        description: '',
        status: '',
        source: ''),
    Novel(
        name: 'Novel 2',
        coverImage: 'assets/images/359s.jpg',
        author: 'None',
        description: '',
        status: '',
        source: ''),
    Novel(
        name: 'Novel 2',
        coverImage: 'assets/images/373s.jpg',
        author: 'None',
        description: '',
        status: '',
        source: ''),
    Novel(
        name: 'Novel 2',
        coverImage: 'assets/images/447s.jpg',
        author: 'None',
        description: '',
        status: '',
        source: ''),
    Novel(
        name: 'Novel 2',
        coverImage: 'assets/images/466s.jpg',
        author: 'None',
        description: '',
        status: '',
        source: ''),
    Novel(
        name: 'Novel 2',
        coverImage: 'assets/images/580s.jpg',
        author: 'None',
        description: '',
        status: '',
        source: ''),
    Novel(
        name: 'Novel 2',
        coverImage: 'assets/images/780s.jpg',
        author: 'None',
        description: '',
        status: '',
        source: ''),
    Novel(
        name: 'Novel 2',
        coverImage: 'assets/images/871s.jpg',
        author: 'None',
        description: '',
        status: '',
        source: ''),
    Novel(
        name: 'Novel 2',
        coverImage: 'assets/images/1303s.jpg',
        author: 'None',
        description: '',
        status: '',
        source: ''),
    Novel(
        name: 'Novel 2',
        coverImage: 'assets/images/1421s.jpg',
        author: 'None',
        description: '',
        status: '',
        source: ''),
    // Ajoutez d'autres novels ici
  ];
  void toggleSearchVisibility(bool visibility) {
    setState(() {
      _isSearchInputVisible = visibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Library',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: ScreenSizes.isMobile(context)
                    ? [
                        SearchWidget(
                          isVisible: _isSearchInputVisible,
                          onVisibilityChanged: toggleSearchVisibility,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_list),
                          onPressed: () {
                            toggleSearchVisibility(false);
                          },
                        ),
                      ]
                    : [
                        SizedBox(
                          width:
                              ScreenSizes.calculateWidthPercentage(context, 55),
                        ),
                        SearchWidget(
                          isVisible: true,
                          onVisibilityChanged: (visible) {},
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        IconButton(
                          icon: const Icon(Icons.filter_list),
                          onPressed: () {},
                        ),
                      ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ScreenSizes.isDesktop(context)
                          ? 7
                          : (ScreenSizes.isTablet(context) ? 4 : 2),
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 15.0,
                      // childAspectRatio: ScreenSizes.getGridItemAspectRatio(context),
                      mainAxisExtent: 270),
                  itemCount: novels.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: (() => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: ((context) =>
                                    NovelScreen(novel: novels[index]))))),
                        child: NovelCard(novel: novels[index]));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
