import '../import_file.dart';
import 'package:vector_math/vector_math.dart' as math3;
import 'package:web_socket_channel/status.dart' as status;
import 'package:dio/dio.dart' as DIO;

class Wall extends StatefulWidget
{
  static String route = 'Wall';
  final Article article;
  Wall({Key key, this.article}): super(key: key);

  @override
  _WallState createState()
  => _WallState();
}

class _WallState extends State<Wall>
{
  double _speed = 50.0;
  ScrollController _scrollController;
  List<Article> _articleList = [];
  IOWebSocketChannel _channel;
  Box<Person> _boxPerson = Hive.box<Person>(GlobalPersonBoxLog);
  Person _person;
  int _limitNumber = 5;  

  Future<void> _getArticleWS() async
  {
    _person = _boxPerson.get(0);
    final jsonObj = {
      "userName": _person.userName,
      "passWord": _person.passWord,
    };
 //   await _channel?.sink?.close(status.goingAway);    
    _channel = IOWebSocketChannel.connect('ws://192.168.1.100:3050/sockserver/websocket',
        pingInterval: const Duration(milliseconds: 31000));
    _channel.sink.add(jsonEncode(jsonObj));    
    _channel.stream.listen((data)
    {
      //print('data');
      _articleList.add(Article.fromJson(jsonDecode(data)));
      _articleList.sort((a, b)=> b.writingTimeUTC.compareTo(a.writingTimeUTC));
      setState((){});
    },
    onError: (err)
    {
      //print(err);
    },
    onDone: () async
    {
      //print('close-client');
      await _channel?.sink?.close(status.goingAway);
      //_channel = IOWebSocketChannel.connect('ws://192.168.1.100:3050',
      //    pingInterval: const Duration(milliseconds: 31000));
      //_channel.sink.add(jsonEncode(jsonObj));
    });
  }

  void _jumpToBottom()
  {
    double distance =
        _scrollController.position.maxScrollExtent - _scrollController.offset;
    double time = (distance / _speed);
    int time2 = time.toInt();
    //print('offset: ' + _scrollController.offset.toString());
    //print('pixels: ' + _scrollController.position.pixels.toString());
    //print('maxScrollExtent: ' + _scrollController.position.maxScrollExtent.toString());
    //setState(() {});
    //_scrollController.addListener(_scrollListener);
    double bottom = _scrollController.position.maxScrollExtent + 2200.0;
    _scrollController.animateTo(
      bottom,
      duration: Duration(seconds: (time2 == 0) ? 1 : time2),
      curve: Curves.linear,
    );
    //_scrollController.addListener(_scrollListener);
  }

  Future<void> _getStreamArticle()
  async {
    if(widget.article != null)
    {
      _articleList.add(widget.article);
    }
//    const String url = 'http://192.168.1.100:3000/article/all';
//    const String url = 'http://192.168.1.100:3000/articleall';
//    const String url = 'http://192.168.1.100:8888/articleall';
    const String url = 'http://192.168.1.100:3000';
    String time;
    if (_articleList.isEmpty)
    {
      time = DateTime.now().toUtc().toIso8601String();
    }
    else
    {
      time = _articleList.last.writingTimeUTC.toIso8601String();
    }
    _person = _boxPerson.get(0);
    final jsonObj = {
      "userName": _person.userName,
      "passWord": _person.passWord,
      "limitNumber": _limitNumber,
      "time": time,
    };
    DIO.RequestOptions option = DIO.RequestOptions();
    option.responseType = DIO.ResponseType.json;
//    option.connectTimeout = 5000;
    option.baseUrl = url;
    option.contentType = DIO.Headers.jsonContentType;
    option.method = 'POST';
    option.data = jsonObj;
    DIO.Dio dio = DIO.Dio();
    DIO.Response response;
    response = await dio.request("/article/all", options: option);
    final List<dynamic> data = jsonDecode(response.data);
    if (data.isEmpty)
    {
      print('null');
      return;
    }
    data.forEach((element)
    {
      Article article = Article.fromJson(element);
      setState(()
      {
        _articleList.add(article);
      });
    });
  }

  void _scrollListener()
  async {
    // if(_scrollController.position.activity.velocity == 0.0)
    // {
    // if(_scrollController.position.pixels < 
    // _scrollController.position.maxScrollExtent)
    // {
    //   _jumpToBottom();
    //   //print('max: ${_scrollController.position.maxScrollExtent}');
    //   //print('pix: ${_scrollController.position.pixels}');
    // }}
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent)
    {
      //_scrollController.removeListener(_scrollListener);
      //print('maxScrollExtent');
      _getStreamArticle();
    }
  }

  void myInitState()
  {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _getArticleWS();
  }

  @override
  void initState()
  {
    super.initState();
    //WidgetsFlutterBinding.ensureInitialized();
    myInitState();
  
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async
    {
      _getStreamArticle();
    });
  }

  Future<void> myDispose() async
  {
    _scrollController.dispose();
    await _channel?.sink?.close(status.goingAway);
  }

  @override
  void dispose()
  {
    myDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    WidgetsBinding.instance.addPostFrameCallback((_)
    => _jumpToBottom());

    return Scaffold(
      //resizeToAvoidBottomPadding: true,
      //resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Wall",
          style: kAppBareStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: FlutterLogo(
              //colors: Colors.indigo,
            ),
            onPressed: ()
            async {
              await _channel?.sink?.close(status.goingAway);
              //Navigator.pushNamed(context, Menu.route);
              Navigator.pushReplacementNamed(context, Menu.route);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/image11.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Transform(
            alignment: Alignment.bottomCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.00107)
              ..rotateX(math3.radians(-45))
              ..scale(1.0, 1.5),
            child: ListView.builder(
              shrinkWrap: true,
              //physics: BouncingScrollPhysics(),
              reverse: false,
              controller: _scrollController,
              itemCount: _articleList.length,
              itemBuilder: (BuildContext context, int index)
              {
                return ArticleWidget(article: _articleList[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
