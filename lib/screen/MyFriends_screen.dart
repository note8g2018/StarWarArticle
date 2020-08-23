import '../import_file.dart';

class MyFriends extends StatelessWidget
{
  static String route = 'MyFriends';

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
          title: Text("My Friends",
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
                  //textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.openSans(
                    fontSize: 25.0,
                    color: Colors.lightBlue,
                  ),
                  decoration: InputDecoration(
                    labelText: "Search by Name",
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
                  child: ListView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
