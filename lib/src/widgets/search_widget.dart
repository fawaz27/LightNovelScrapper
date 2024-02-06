import 'package:flutter/material.dart';

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
    return isVisible
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      
                    },
                  ),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      onVisibilityChanged(false);
                    },
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
          )
        : IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              onVisibilityChanged(true);
            },
          );
  }
}
