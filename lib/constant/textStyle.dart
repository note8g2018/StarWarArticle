import '../import_file.dart';

final TextStyle kAppBareStyle = GoogleFonts.aclonica(
  textStyle: TextStyle(
    fontSize: 30.0,
    color: Colors.greenAccent,
    shadows: <Shadow>[
      Shadow(
        offset: Offset(0.0, 0.0),
        blurRadius: 10.0,
        color: Color.fromARGB(255, 0, 255, 0),
      ),
      Shadow(
        offset: Offset(0.0, 0.0),
        blurRadius: 15.0,
        color: Color.fromARGB(125, 0, 255, 0),
      ),
    ],
  ),
);

final TextStyle kRoleStyle = GoogleFonts.roboto(
  color: Colors.amber,
  fontSize: 20.0,
);

