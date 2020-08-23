import '../import_file.dart';

class Menu extends StatefulWidget
{
  static const String route = 'Menu';

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  File _imageFile;
  final ImagePicker _picker = ImagePicker();
  Box<Person> _boxPerson = Hive.box<Person>(GlobalPersonBoxLog);

  void _logOut(BuildContext context) async
  {
    final Person person = _boxPerson.get(0);
    await LogOutController.logout(person);
    _boxPerson.delete(0);
    Navigator.pushNamed(context, LogIn.route);
  }

  void _getImage() async
  {
    PickedFile _pickedFile = await _picker.getImage(source: ImageSource.camera);
    File _croppedFileImage = await ImageCropper.cropImage(
      sourcePath: _pickedFile.path,
      cropStyle: CropStyle.circle,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0,)
    );

    setState(() {
      _imageFile = _croppedFileImage;
    });
  }

  ImageProvider _getImageWidget(File imageFile)
  {
    if(imageFile == null)
      {
        return AssetImage("images/image19.png",
          //height: 200.0,
          //width: 200.0,
        );
      }
    else
      {
        return FileImage(_imageFile,
          //height: 200.0,
          //width: 200.0,
        );
      }
  }

  @override
  Widget build(BuildContext context)
  {    
    return Scaffold(
      //resizeToAvoidBottomInset: true,
      //resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text("Menu",
          style: kAppBareStyle,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
              child: GestureDetector(
                onTap: (){
                  _getImage();
                },
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundImage: _getImageWidget(_imageFile),
                  backgroundColor: Colors.cyan,
                ),
              ),
                ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.start,
                  spacing: 15.0,
                  runSpacing: 15.0,
                  children: <Widget>[
                    LinkBall(
                      title: "Write Article",
                      onTap: (){
                        Navigator.pushNamed(context, WritingArticle.route);
                      },
                    ),
                    LinkBall(
                      title: "Wall",
                      onTap: (){
                        Navigator.pushNamed(context, Wall.route);
                      },
                    ),
                    // LinkBall(
                    //   title: "My Friends",
                    //   onTap: (){
                    //     Navigator.pushNamed(context, MyFriends.route);
                    //   },
                    // ),
                    // LinkBall(
                    //   title: "Add Friend",
                    //   onTap: (){
                    //     Navigator.pushNamed(context, AddFriend.route);
                    //   },
                    // ),
                    LinkBall(
                      title: "Log Out",
                      onTap: (){
                        _logOut(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


