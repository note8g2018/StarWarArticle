import 'import_file.dart';
import 'package:path_provider/path_provider.dart' as path;

const String GlobalPersonBoxLog = "GlobalPersonBoxLog";
const String myAppID = "coolme";
const String urld =
    'mongodb://note8g2018:123456789@localhost:27017/flutter?authSource=admin';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  final Directory _directory = await path.getApplicationDocumentsDirectory();
  final String _hivePath = _directory.path;
  //debugPrint(_hivePath);
  Hive.init(_hivePath);
  //await Hive.initFlutter();
  //Hive.registerAdapter<ObjectId>(ObjectId(), 0);
  Hive.registerAdapter(PersonAdapter());
  await Hive.openBox<Person>(GlobalPersonBoxLog);

  runApp(MyApp());
}




