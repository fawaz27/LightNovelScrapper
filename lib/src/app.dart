import 'package:flutter/material.dart';

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
        home: const HomeScreen(),debugShowCheckedModeBanner: false,);
        
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    Container(
      color: Colors.yellow.shade500,
      alignment: Alignment.center,
      child: const Text(
        'Library',
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.purple.shade500,
      alignment: Alignment.center,
      child: const Text(
        'History',
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.red.shade500,
      alignment: Alignment.center,
      child: const Text(
        'Explore',
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.pink.shade500,
      alignment: Alignment.center,
      child: const Text(
        'Settings',
        style: TextStyle(fontSize: 40),
      ),
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LNScrapper')),
      bottomNavigationBar:MediaQuery.of(context).size.width < 640? BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.indigoAccent,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ):null,
      body: Row(
        children: [
          if(MediaQuery.of(context).size.width >= 640)
          NavigationRail(
            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: const TextStyle(
              color: Colors.indigoAccent 
            ),
            selectedIconTheme: IconThemeData(color: Colors.indigoAccent),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.library_books),
                label: Text('Library'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history),
                label: Text('History'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.explore),
                label: Text('Explore'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}
