import '../import_file.dart';

class UserNameContainer extends StatelessWidget {

  final Function onPressed;
  final TextEditingController textEditingController;
  const UserNameContainer({this.onPressed, this.textEditingController});

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
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9a-z]')),          
              LengthLimitingTextInputFormatter(28),
            ],
            keyboardType: TextInputType.text,
            style: GoogleFonts.openSans(
              fontSize: 25.0,
              color: Colors.purpleAccent,
            ),
            decoration: InputDecoration(
              labelText: "User Name",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("1.\t", style: kRoleStyle,),
              Expanded(
                flex: 1,
                child: Text("At least 8 characters [8, 28]",
                  style: kRoleStyle,),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("2.\t", style: kRoleStyle,),
              Expanded(
                flex: 1,
                child: Text("The first three must be from [a, z]",
                  style: kRoleStyle,),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("3.\t", style: kRoleStyle,),
              Expanded(
                flex: 1,
                child: Text("The rest must be from [a, z] or [0, 9]",
                  style: kRoleStyle,),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: FlatButton(
                  padding: EdgeInsets.all(15.0),
                  color: Colors.green,
                  //elevation: 5.0,
                  onPressed: onPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Next",
                        style: GoogleFonts.pangolin(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      FaIcon(
                        FontAwesomeIcons.arrowAltCircleRight,
                        size: 40.0,
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
