import 'package:flutter/material.dart';
import 'package:lnscraper/src/utils/screen_sizes.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  bool _isSearchVisible = false;

  void toggleSearchVisibility() {
    setState(() {
      _isSearchVisible = !_isSearchVisible;
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
                children: [
                  if (_isSearchVisible ||
                      ScreenSizes.isTablet(context) &&
                          ScreenSizes.isDesktop(context))
                    SizedBox(
                      width: ScreenSizes.calculateWidthPercentage(context, 60),
                    ),
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {},
                  ),
                  if (_isSearchVisible && ScreenSizes.isMobile(context))
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        toggleSearchVisibility();
                      },
                    ),
                  if (_isSearchVisible ||
                      ScreenSizes.isTablet(context) &&
                          ScreenSizes.isDesktop(context))
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search...',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {

                        },
                      ),
                    )),
                  if (_isSearchVisible && ScreenSizes.isMobile(context))
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        toggleSearchVisibility();
                      },
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
