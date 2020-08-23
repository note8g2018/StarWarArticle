import '../import_file.dart';

class Register extends StatefulWidget
{
  static String route = 'Register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin
{
  AnimationController _controllerTranslate;
  AnimationController _controllerOthers;
  Animation<double> _animationSkew;
  Animation<double> _animationScale;
  Animation<double> _animationTranslate;
  String _userName;
  String _emil;
  String _passWord1;
  String _passWord2;
  TextEditingController _userNameController;
  TextEditingController _emailController;
  TextEditingController _passWord1Controller;
  TextEditingController _passWord2Controller;
  Box<Person> _boxPerson = Hive.box<Person>(GlobalPersonBoxLog);

  void _showSnackBar(String text, BuildContext context)
  {
    final SnackBar mySnackBar = SnackBar(
      content: Text(
        text,
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
      backgroundColor: Color.fromRGBO(255, 0, 0, 1.0),
      duration: Duration(seconds: 10,),
      elevation: 7.0,
    );

    Scaffold.of(context).showSnackBar(mySnackBar);
  }

  Future<bool> _checkUserName(BuildContext context) async
  {
    _userName = _userNameController.value.text.trim();
    if(!ValidateDate.userName(_userName))
      {
        const String text = "The User Name is not Valid, please read rules carefully!!!";
        _showSnackBar(text, context);
        return false;
      }
    final Map<String, dynamic> jsonOdj = {
      "userName": _userName,
      "result": null,
    };
    TravelMessage travelMessage = await Registration.checkUserName(jsonObj: jsonOdj);
    if(!travelMessage.result)
      {
        _showSnackBar(travelMessage.description, context);
        return false;
      }else
        {
          return true;
        }
  }

  Future<bool> _checkEmail(BuildContext context) async
  {
    _emil = _emailController.value.text.toLowerCase().trim();
    if(!ValidateDate.email(_emil))
    {
      const String text = "The Email is not Valid, please read rules carefully!!!";
      _showSnackBar(text, context);
      return false;
    }
    final Map<String, dynamic> jsonOdj = {
      "email": _emil,
      "result": null,
    };
    TravelMessage travelMessage = await Registration.checkEmail(jsonObj: jsonOdj);
    if(!travelMessage.result)
    {
      _showSnackBar(travelMessage.description, context);
      return false;
    }else
    {
      return true;
    }
  }

  bool _checkPassWord1(BuildContext context)
  {
    _passWord1 = _passWord1Controller.value.text.trim();
    if(!ValidateDate.passWord1(_passWord1))
    {
      const String text = "This PassWord is not Valid, please read rules carefully!!!";
      _showSnackBar(text, context);
      return false;
    }
    else
    {
      return true;
    }
  }

  bool _checkPassWord2(BuildContext context)
  {
    _passWord2 = _passWord2Controller.value.text.trim();
    if(!ValidateDate.passWord2(_passWord1, _passWord2))
    {
      const String text = "The PassWord does not match";
      _showSnackBar(text, context);
      return false;
    }
    else
    {
      return true;
    }
  }

  Future<bool> _register(BuildContext context) async
  {
    final Map<String, dynamic> jsonOdj = {
      "userName": _userName,
      "email": _emil,
      "passWord": _passWord2,
    };
    TravelMessage travelMessage = await Registration.register(jsonObj: jsonOdj);
    if(!travelMessage.result)
    {
      _showSnackBar(travelMessage.description, context);
      return false;
    }else
    {
      Person person = await LoginController.loginPerson(jsonObj: jsonOdj);
      _boxPerson.put(0, person);
      Navigator.pushNamed(context, Menu.route);
    }
  }


  @override
  void initState() {
    super.initState();

    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passWord1Controller = TextEditingController();
    _passWord2Controller = TextEditingController();

    _controllerTranslate = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2,),
    );

    _controllerOthers = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2,),
    );

    _animationSkew = Tween<double>(
      begin: 0.0,
      end: -0.15,
    ).animate(
      CurvedAnimation(
      parent: _controllerOthers,
      curve: Interval(0.0, 1.0, curve: Curves.bounceInOut),
      ),
    );

    _animationScale = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(
      CurvedAnimation(
          parent: _controllerOthers,
          curve: Interval(0.0, 1.0, curve: Curves.easeInOutBack),
      ),
    );

    _animationTranslate = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
      parent: _controllerTranslate,
      curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

  }

  @override
  void dispose() async
  {
    await _boxPerson.compact();
    _controllerTranslate.dispose();
    _controllerOthers.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passWord1Controller.dispose();
    _passWord2Controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context)
  {
    final MediaQueryData mediaQueryDate = MediaQuery.of(context);
    final double width2 = mediaQueryDate.size.width;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text("Register",
            style: kAppBareStyle,
          ),
        ),
        body: Builder(
          builder: (context) => SafeArea(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 0.0,
                  left: 0.0,
                  width: width2,
                  child: AnimatedBuilder(
                    animation: _controllerOthers,
                    child: UserNameContainer(
                      textEditingController: _userNameController,
                      onPressed: () async {
                        if(await _checkUserName(context))
                          {
                            _controllerTranslate.reset();
                            _animationTranslate = Tween<double>(
                              begin: 0.0,
                              end: 1.0,
                            ).animate(
                              CurvedAnimation(
                                parent: _controllerTranslate,
                                curve: Interval(0.0, 1.0, curve: Curves.easeInBack),
                              ),
                            );

                            _controllerOthers.forward().whenComplete(
                                    () => _controllerTranslate.forward()
                                    .whenComplete(() => _controllerOthers.reverse())
                            );
                          }
                      },
                    ),
                    builder: (BuildContext context, Widget child)
                    {
                      return AnimatedBuilder(
                        child: child,
                        animation: _controllerTranslate,
                        builder: (BuildContext context, Widget child)
                        {
                          return Transform(
                            child: child,
                            alignment: Alignment.center,
                            transform: Matrix4.skewX(_animationSkew.value)
                              ..scale(_animationScale.value)
                              ..translate(width2 * -_animationTranslate.value),
                          );
                        },
                      );
                    },
                    ),

                ),
                Positioned(
                  top: 0.0,
                  left: width2,
                  width: width2,
                  child: AnimatedBuilder(
                    child: EmailContainer(
                      textEditingController: _emailController,
                      onPressedNext: () async {
                        if(await _checkEmail(context))
                          {
                            _controllerTranslate.reset();
                            _animationTranslate = Tween<double>(
                              begin: 1.0,
                              end: 2.0,
                            ).animate(
                              CurvedAnimation(
                                parent: _controllerTranslate,
                                curve: Interval(0.0, 1.0, curve: Curves.easeInBack),
                              ),
                            );

                            _controllerOthers.forward().whenComplete(
                                    () => _controllerTranslate.forward()
                                    .whenComplete(() => _controllerOthers.reverse())
                            );
                          }
                      },
                      onPressedBack: (){

                        _controllerTranslate.reset();
                        _animationTranslate = Tween<double>(
                          begin: 1.0,
                          end: 0.0,
                        ).animate(
                          CurvedAnimation(
                            parent: _controllerTranslate,
                            curve: Interval(0.0, 1.0, curve: Curves.easeInBack),
                          ),
                        );

                        _controllerOthers.forward().whenComplete(
                                () => _controllerTranslate.forward()
                                .whenComplete(() => _controllerOthers.reverse())
                        );
                      },
                    ),
                      animation: _controllerOthers,
                      builder: (BuildContext context, Widget child)
                      {
                        return AnimatedBuilder(
                          child: child,
                          animation: _controllerTranslate,
                          builder: (BuildContext context, Widget child)
                          {
                            return Transform(
                              alignment: Alignment.center,
                              child: child,
                              transform: Matrix4.skewX(_animationSkew.value)
                                ..scale(_animationScale.value)
                                ..translate(width2 * -_animationTranslate.value),
                            );
                          },
                        );
                      },
                    ),
                  ),
                Positioned(
                  top: 0.0,
                  left: (2*width2),
                  width: width2,
                  child: AnimatedBuilder(
                    child: Password1Container(
                      textEditingController: _passWord1Controller,
                      onPressedNext: (){
                        if(_checkPassWord1(context))
                          {
                            _controllerTranslate.reset();
                            _animationTranslate = Tween<double>(
                              begin: 2.0,
                              end: 3.0,
                            ).animate(
                              CurvedAnimation(
                                parent: _controllerTranslate,
                                curve: Interval(0.0, 1.0, curve: Curves.easeInBack),
                              ),
                            );

                            _controllerOthers.forward().whenComplete(
                                    () => _controllerTranslate.forward()
                                    .whenComplete(() => _controllerOthers.reverse())
                            );
                          }
                      },
                      onPressedBack: (){

                        _controllerTranslate.reset();
                        _animationTranslate = Tween<double>(
                          begin: 2.0,
                          end: 1.0,
                        ).animate(
                          CurvedAnimation(
                            parent: _controllerTranslate,
                            curve: Interval(0.0, 1.0, curve: Curves.easeInBack),
                          ),
                        );

                        _controllerOthers.forward().whenComplete(
                                () => _controllerTranslate.forward()
                                .whenComplete(() => _controllerOthers.reverse())
                        );
                      },
                    ),
                    animation: _controllerOthers,
                    builder: (BuildContext context, Widget child)
                    {
                      return AnimatedBuilder(
                        child: child,
                        animation: _controllerTranslate,
                        builder: (BuildContext context, Widget child)
                        {
                          return Transform(
                            alignment: Alignment.center,
                            child: child,
                            transform: Matrix4.skewX(_animationSkew.value)
                              ..scale(_animationScale.value)
                              ..translate(width2 * -_animationTranslate.value),
                          );
                        },
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 0.0,
                  left: 3*width2,
                  width: width2,
                  child: AnimatedBuilder(
                    child: Password2Container(
                      textEditingController: _passWord2Controller,
                      onRegister: (){
                        if(_checkPassWord2(context))
                          {
                            _register(context);
                          }
                      },
                      onPressedBack: (){

                        _controllerTranslate.reset();
                        _animationTranslate = Tween<double>(
                          begin: 3.0,
                          end: 2.0,
                        ).animate(
                          CurvedAnimation(
                            parent: _controllerTranslate,
                            curve: Interval(0.0, 1.0, curve: Curves.easeInBack),
                          ),
                        );

                        _controllerOthers.forward().whenComplete(
                                () => _controllerTranslate.forward()
                                .whenComplete(() => _controllerOthers.reverse())
                        );
                      },
                    ),
                    animation: _controllerOthers,
                    builder: (BuildContext context, Widget child)
                    {
                      return AnimatedBuilder(
                        child: child,
                        animation: _controllerTranslate,
                        builder: (BuildContext context, Widget child)
                        {
                          return Transform(
                            alignment: Alignment.center,
                            child: child,
                            transform: Matrix4.skewX(_animationSkew.value)
                              ..scale(_animationScale.value)
                              ..translate(width2 * -_animationTranslate.value),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


