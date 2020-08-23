import '../import_file.dart';

class ArticleWidget extends StatelessWidget
{
  final Article article;

  const ArticleWidget({
    this.article,
  });

  static const Color _starWarColor = Color.fromRGBO(229, 177, 58, 1.0);
  static const TextStyle _kStarTextStyle = TextStyle(
    fontSize: 60.0,
    fontWeight: FontWeight.bold,
    color: _starWarColor,
    fontFamily: "SWCrawlBody",
    letterSpacing: 3.0,
    shadows: [
      Shadow(
        color: Colors.black,
        blurRadius: 2.0,
        offset: Offset(5.0, 10.0),
      ),
    ],
  );

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 100.0,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: article.title.toUpperCase(),
            style: _kStarTextStyle,
          ),
        ),
        RichText(
          textAlign: TextAlign.start,
            text: TextSpan(
              text: article.author[0].toUpperCase() + article.author.substring(1),
              style: _kStarTextStyle.copyWith(
                color: Colors.purpleAccent,
                fontSize: 50.0,
              ),
          ),
        ),
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: 'wrote this article from Galaxy far far away in:',
            style: _kStarTextStyle.copyWith(
              fontSize: 40.0,
            ),
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: article.writingTimeUTC.toLocal().toString(),
            style: _kStarTextStyle.copyWith(
              fontSize: 35.0,
              color: Colors.teal,
            ),
          ),
        ),
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: article.body,
            style: _kStarTextStyle,
          ),
        ),
        SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}
