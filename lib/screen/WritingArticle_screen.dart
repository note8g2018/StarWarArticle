import '../import_file.dart';

class WritingArticle extends StatefulWidget
{
  static String route = 'WritingArticle';

  @override
  _WritingArticleState createState() => _WritingArticleState();
}

class _WritingArticleState extends State<WritingArticle>
{
  Box<Person> _boxPerson = Hive.box<Person>(GlobalPersonBoxLog);
  TextEditingController _titleController;
  TextEditingController _bodyController;

  _sendArticle(BuildContext context) async
  {
    if(_titleController.text.trim().isNotEmpty && _bodyController.text.trim().isNotEmpty)
    {
      final Article _article = Article(
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
        author: _boxPerson
            .get(0)
            .userName,
        isPublic: true,
        writingTimeUTC: DateTime.now().toUtc(),
      );
      bool result = await ArticleController.send(article: _article);
      if(result)
        {
          //Navigator.pushNamed(context, Wall3.route,arguments: _article);
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Wall(article: _article,),
          ),
        );
          //await Future.delayed(const Duration(milliseconds: 1450));
          //Navigator.pushReplacementNamed(context, Wall3.route);
        }
    }
  }

  @override
  void initState()
  {
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
  }

  Future<void> myDispose() async
  {
    _titleController.dispose();
    _bodyController.dispose();
    await _boxPerson.compact();
  }

  @override
  void dispose() async
  {
    myDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        //resizeToAvoidBottomPadding: true,
        //resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Writing Article",
            style: kAppBareStyle.copyWith(fontSize: 25,),
          ),
          actions: <Widget>[
            IconButton(
              icon: FlutterLogo(
                //colors: Colors.indigo,
              ),
              onPressed: (){
                Navigator.pushNamed(context, Menu.route);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _titleController,
                  //textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.openSans(
                    fontSize: 25.0,
                    color: Colors.lightBlue,
                  ),
                  decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 25.0,
                    ),
                    border: OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: const BorderSide(color: Colors.orange, width: 0.0),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.only(
                    top: 5.0,
                    left: 10.0,
                    right: 10.0,
                    bottom: 0.0,
                  ),
                  child: TextFormField(
                    controller: _bodyController,
                    scrollPadding: EdgeInsets.zero,
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: null,
                    minLines: null,
                    maxLengthEnforced: true,
                    expands: true,
                    style: GoogleFonts.openSans(
                      fontSize: 25.0,
                      color: Colors.purpleAccent,
                    ),
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "The Article",
                      labelStyle: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 25.0,
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide: const BorderSide(color: Colors.orange, width: 0.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: FlatButton(
                  onPressed: (){
                    _sendArticle(context);
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.all(0.0),
                  color: Colors.green,
                  child: Text(
                    "Send",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pangolin(
                      fontSize: 25.0,
                      //height: 2.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
