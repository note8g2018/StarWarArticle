import '../import_file.dart';

class LinkBall extends StatelessWidget {
  const LinkBall({
    Key key,
    this.title,
    this.onTap,
  }) : super(key: key);

  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          alignment: Alignment.center,
          height: 100.0,
          width: 100.0,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.green.withOpacity(1.0),
                Colors.green.withOpacity(0.1),
              ],
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.abel(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}