import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zetaton/core/util/services/service_locator.dart';
import 'package:zetaton/modules/details/photo_details_provider.dart';
import 'package:zetaton/modules/favorites/presentation/controllers/favorites_provider.dart';
import 'package:zetaton/modules/landing/presentation/screens/landing_screen.dart';
import 'package:zetaton/modules/authentication/presentation/controllers/login_provider.dart';
import 'package:zetaton/modules/authentication/presentation/controllers/register_provider.dart';
import 'package:zetaton/modules/search/presentation/controllers/search_provider.dart';
import 'package:zetaton/firebase_options.dart';
import 'package:zetaton/modules/home/presentation/controllers/home_provider.dart';
import 'package:zetaton/modules/authentication/presentation/screens/login/login_screen.dart';
import 'package:zetaton/routes/app_pages.dart';
import 'package:zetaton/services/user_provider.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ServicesLocator().init();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox<String>('favoriteWallpapers');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  await FlutterDownloader.initialize(debug: true // Set to false in production
      );
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(
            create: (_) =>
                FavoritesProvider(Hive.box<String>('favoriteWallpapers'))),

        ChangeNotifierProvider(create: (_) => sl<WallpaperProvider>()),
        ChangeNotifierProvider(create: (_) => sl<SearchProvider>()),
        ChangeNotifierProvider(
            create: (_) =>
                PhotoDetailsProvider(Hive.box<String>('favoriteWallpapers'))),
        // Add other providers if needed
      ],
      child: MaterialApp(
        routes: AppPages.routes,
        debugShowCheckedModeBanner: false,
        title: 'My App',
        home: isLoggedIn ? const LandingScreen() : LoginPage(),
      ),
    );
  }
}
