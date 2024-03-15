import 'package:flutter/material.dart';
import 'package:lnscraper/src/view_model/library_viewmodel.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  final bool isVisible;
  final Function(bool) onVisibilityChanged;

  const SearchWidget({
    super.key,
    required this.isVisible,
    required this.onVisibilityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryViewModel>(builder: (context, viewModel, child) {
      return isVisible
          ? Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        onVisibilityChanged(false);
                      },
                    ),
                  ),
                  onChanged: (value) => viewModel.filterNovel(value),
                ),
              ),
            )
          : IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                onVisibilityChanged(true);
              },
            );
    });
  }
}
