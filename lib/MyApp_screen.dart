import './import_file.dart';

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.green,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.green,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),

        title: 'CoolME',
        initialRoute: LogIn.route,
        routes:
        {
          LogIn.route: (context) => LogIn(),
          Register.route: (context) => Register(),
          WritingArticle.route: (context) => WritingArticle(),
          Wall.route: (context) => Wall(),          
          Menu.route: (context) => Menu(),
          AddFriend.route: (context) => AddFriend(),
          MyFriends.route: (context) => MyFriends(),
        },
      ),
    );
  }
}
