import 'package:flutter/material.dart';
import 'package:lnscraper/src/views/library.dart';
import 'package:lnscraper/src/views/explore.dart';
import 'package:lnscraper/src/views/history.dart';
import 'package:lnscraper/src/views/settings.dart';
import 'package:lnscraper/src/utils/screen_sizes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Namer App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
      ),
      home: const MainAppScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});
  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  final List<Map<String, dynamic>> _navigationItems = [
    {
      'screen': const LibraryScreen(),
      'item': const BottomNavigationBarItem(
        icon: Icon(Icons.library_books),
        label: 'Library',
      ),
    },
    {
      'screen': const HistoryScreen(),
      'item': const BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'History',
      ),
    },
    {
      'screen': const ExploreScreen(),
      'item': const BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        label: 'Explore',
      ),
    },
    {
      'screen': const SettingsScreen(),
      'item': const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    },
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ScreenSizes.isMobile(context)
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.indigoAccent,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: _navigationItems
                  .map<BottomNavigationBarItem>((item) => item['item'])
                  .toList(),
            )
          : null,
      body: Row(
        children: [
          if (!ScreenSizes.isMobile(context))
            NavigationRail(
              // extended: ScreenSizes.isDesktop(context),
              elevation: 5,
              backgroundColor: Colors.grey[100],
              labelType:  NavigationRailLabelType.all,
              selectedLabelTextStyle:
                  const TextStyle(color: Colors.indigoAccent, fontSize: 18),
              unselectedLabelTextStyle: const TextStyle(
                fontSize: 16, 
                color: Color.fromARGB(255, 105, 102, 102), 
              ),
              leading: const SizedBox(height: 40),
              selectedIconTheme:
                  const IconThemeData(color: Colors.indigoAccent),
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: _navigationItems
                  .map<NavigationRailDestination>(
                      (item) => NavigationRailDestination(
                            icon: item['item'].icon,
                            label: Text(item['item'].label),
                          ))
                  .toList(),
            ),
          Expanded(child: _navigationItems[_selectedIndex]['screen']),
        ],
      ),
    );
  }
}
