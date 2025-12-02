import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// ✅ Import service-level logic
import 'package:capstoneproject/services/main.dart' as services_main;

// ✅ App imports
import 'package:capstoneproject/services/screens/home_screens.dart';
import 'package:capstoneproject/services/screens/scan_history_screen.dart';
import 'package:capstoneproject/services/screens/permission_privacy_screen.dart';
import 'package:capstoneproject/services/database/database.dart';

Future<void> main() async {
  // 1️⃣ Ensure Flutter bindings are initialized before async calls
  WidgetsFlutterBinding.ensureInitialized();

  // 2️⃣ Load environment variables from the .env file (if it exists)
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // .env file not found, will use fallback API key from app_services.dart
    print('Warning: .env file not found. Using fallback API key.');
  }

  // 3️⃣ Initialize local database (Drift or SQFLite)
  final database = AppDatabase();
  await database.init();
  await database.populateDefaultThreats();

  // 4️⃣ Run additional service-level initialization logic
  services_main.main();

  // 5️⃣ Launch the main Flutter UI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoC Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue[700],
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    ScanHistoryScreen(),
    const PermissionPrivacyScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'Scan'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.policy), label: 'Permissions'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
