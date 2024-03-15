import 'package:flutter/material.dart';
import 'package:lnscraper/src/models/chapter.dart';
import 'package:lnscraper/src/utils/filter.dart';
import 'package:lnscraper/src/view_model/library_viewmodel.dart';
import 'dart:io';
import 'dart:convert';
import 'package:lnscraper/src/views/novel_info.dart';
import 'package:lnscraper/src/utils/screen_sizes.dart';
import 'package:lnscraper/src/widgets/search_widget.dart';
import 'package:lnscraper/src/models/novel.dart';
import 'package:lnscraper/src/widgets/novel_card.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool _isSearchInputVisible = false;

  void toggleSearchVisibility(bool visibility) {
    setState(() {
      _isSearchInputVisible = visibility;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void reloadNovels() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LibraryViewModel(path: 'download')..loadNovels(),
        child: Scaffold(
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
                          ReloadButton()
                        ]
                      : [
                          SizedBox(
                            width: ScreenSizes.calculateWidthPercentage(
                                context, 55),
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
                          ReloadButton()
                        ],
                ),
                const SizedBox(height: 15),
                Expanded(child: LibraryList()),
              ],
            ),
          ),
        )));
  }
}

class ReloadButton extends StatelessWidget {
  const ReloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryViewModel>(builder: (context, viewModel, child) {
      return IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () => viewModel.reload(),
      );
    });
  }
}

class LibraryList extends StatelessWidget {
  const LibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final sources = viewModel.sources;
          return ListView.builder(
            itemCount: sources.length,
            itemBuilder: (BuildContext context, int index) {
              final source = sources[index];
              final novels = source.novels;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      source.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ScreenSizes.isDesktop(context)
                          ? 7
                          : (ScreenSizes.isTablet(context) ? 4 : 2),
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 15.0,
                      mainAxisExtent: 270,
                    ),
                    itemCount: novels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (() => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: ((context) =>
                                    NovelInfoScreen(novel: novels[index]))))),
                        child: NovelCard(novel: novels[index]),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
