import 'package:flutter/material.dart';
import 'package:helloworld/pages/metaldector_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

enum AppScreen { Home, Search, Profile }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salomon Bottom Bar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (BuildContext context) => MetalDetectorApp(),
        '/search': (BuildContext context) => MetalDetectorApp(),
        '/profile': (BuildContext context) => MetalDetectorApp(),
      },
      home: BottomBarScreen(),
    );
  }
}

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  AppScreen _currentScreen = AppScreen.Home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salomon Bottom Bar Demo'),
      ),
      body: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return MetalDetectorApp();
                case '/search':
                  return MetalDetectorApp();
                case '/profile':
                  return MetalDetectorApp();
                default:
                  return MetalDetectorApp();
              }
            },
          );
        },
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentScreen.index,
        onTap: (index) {
          setState(() {
            _currentScreen = AppScreen.values[index];
          });
          switch (_currentScreen) {
            case AppScreen.Home:
              Navigator.pushNamed(context, '/');
              break;
            case AppScreen.Search:
              Navigator.pushNamed(context, '/search');
              break;
            case AppScreen.Profile:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
            selectedColor: Colors.green,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
