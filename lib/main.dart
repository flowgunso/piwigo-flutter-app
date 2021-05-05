import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:piwigo_ng/services/theme_provider.dart';
import 'package:piwigo_ng/views/RootCategoryViewPage.dart';
import 'package:piwigo_ng/api/API.dart';
import 'package:provider/provider.dart';
import 'package:piwigo_ng/views/LoginViewPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await getSharedPreferences();
  runApp(MyApp());
}

Future<void> getSharedPreferences() async {
  API.prefs = await SharedPreferences.getInstance();
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: 'Piwigo',
            // theme: notifier.darkTheme ? dark : light,
            theme: light,
            initialRoute: '/',
            // routes: {
            //   '/': (context) => LoginViewPage(),
            //   '/root': (context) => RootCategoryViewPage()
            // },
            onGenerateRoute: (settings) {
              if(settings.name == '/') return MaterialPageRoute(builder: (context) => LoginViewPage());
              if(settings.name == '/root') return MaterialPageRoute(builder: (context) => RootCategoryViewPage(isAdmin: settings.arguments));
              return MaterialPageRoute(builder: (context) => Container());
            },
          );
        }
      ),
    );
  }
}



