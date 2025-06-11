import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poltry_farm/shared/local_database/user_box.dart';
import 'package:poltry_farm/shared/local_database/user_db_model.dart';

class HiveLocalDb {
  HiveLocalDb._internal();

  static final HiveLocalDb _instance = HiveLocalDb._internal();
  static HiveLocalDb get instance => _instance;

  static late final UserBox _userBox;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    Hive.registerAdapter(UserDbModelAdapter());

    final userBox = await Hive.openBox<UserDbModel>('userBox');

    _userBox = UserBoxImpl(userBox);
  }

  UserBox get userBox => _userBox;

  Future<void> clearAll() async {
    await _userBox.clear();
  }

  Future<void> close() async {
    await Hive.close();
  }
}
