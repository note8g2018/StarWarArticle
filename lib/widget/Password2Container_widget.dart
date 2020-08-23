import '../import_file.dart';

class Password2Container extends StatelessWidget
{
  final Function onRegister;
  final Function onPressedBack;
  final TextEditingController textEditingController;
  const Password2Container({this.onRegister, this.onPressedBack, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.green,
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      child: ListView(
        padding: EdgeInsets.only(top: 15.0,),
        shrinkWrap: true,
        children: <Widget>[
          TextFormField(
            controller: textEditingController,
            obscureText: true,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9!@#\$%^&*()_+=-]')),    
              LengthLimitingTextInputFormatter(31),
            ],
            keyboardType: TextInputType.visiblePassword,
            style: GoogleFonts.openSans(
              fontSize: 25.0,
              color: Colors.purpleAccent,
            ),
            decoration: InputDecoration(
              labelText: "Repeat Password",
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
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: FlatButton(
                  padding: EdgeInsets.all(15.0),
                  color: Colors.red,
                  //elevation: 5.0,
                  onPressed: onPressedBack,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: FaIcon(
                          FontAwesomeIcons.arrowAltCircleLeft,
                          size: 40.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "Back",
                        style: GoogleFonts.pangolin(
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: FlatButton(
                  padding: EdgeInsets.all(15.0),
                  color: Colors.green,
                  //elevation: 5.0,
                  onPressed: onRegister,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Register",
                          style: GoogleFonts.pangolin(
                            fontSize: 28.0,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}