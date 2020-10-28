import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String carTable = "carTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String boardColumn = "boardColumn";
final String colorColumn = "colorColumn";
final String ownerColumn = "ownerColumn";
final String phoneColumn = "phoneColumn";
final String localeColumn = "localeColumn";
final String timeColumn = "timeColumn";

class CarHelper {
	static final CarHelper _instance = CarHelper.internal();

	factory CarHelper() => _instance;

	CarHelper.internal();

	Database _db;

	Future<Database> get db async {
		if(_db != null) {
			return _db;
		} else {
			_db = await initDb();
			return _db;
		}
	}

	Future<Database> initDb() async {
		final databasesPath = await getDatabasesPath();
		final path = join(databasesPath, "estaciona_car.db");

		return await openDatabase(
			path, 
			version: 1, 
			onCreate: (Database db, int newerVersion) async {
				await db.execute(
					"CREATE TABLE $carTable("
						"$idColumn INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
						"$nameColumn TEXT NOT NULL, "
						"$boardColumn TEXT NOT NULL, "
						"$colorColumn TEXT NOT NULL, "
						"$ownerColumn TEXT NOT NULL, "
						"$phoneColumn TEXT NOT NULL, "
            "$localeColumn TEXT NOT NULL,"
						"$timeColumn TEXT NOT NULL"
					");"
				);
			}
		);
	}

	Future close() async {
		Database dbCar = await db;
		dbCar.close();
	}
}