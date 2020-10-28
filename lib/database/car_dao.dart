import 'package:estaciona_car/database/car_helper.dart';
import 'package:estaciona_car/models/car.dart';
import 'package:sqflite/sqflite.dart';

final String carTable = "carTable";

class CarDao {
	Future<Car> insert(Car car) async {
    Database db = await CarHelper().db;
    car.id = await db.insert(carTable, car.toMap());
    return car;
	}

	Future<List> getAll() async {
	  Database db = await CarHelper().db;
		List listMap = await db.rawQuery("SELECT * FROM $carTable");

		List<Car> list = List();
		
		for(Map map in listMap) {
			list.add(Car.fromMap(map));
		}

		return list;
	}

	Future<Car> getById(int id) async {
		Database db = await CarHelper().db;

		List<Map> maps = await db.query(
			carTable,
			columns: [idColumn, nameColumn],
			where: "$idColumn = ?",
			whereArgs: [id]);

		if(maps.length > 0) {
			return Car.fromMap(maps.first);
		} else {
			return null;
		}
	}

	Future<int> update(Car car) async {
		Database db = await CarHelper().db;
		return await db.update(
			carTable, 
			car.toMap(), 
			where: "$idColumn = ?", 
			whereArgs: [car.id]
		);
	}

	Future<int> delete(int id) async {
		Database db = await CarHelper().db;
		return await db.delete(
			carTable, 
			where: "$idColumn = ?", 
			whereArgs: [id]
		);
	}

	Future<int> count() async {
		Database db = await CarHelper().db;
		return Sqflite.firstIntValue(await db.rawQuery(
			"SELECT COUNT(*) FROM $carTable"
		));
	}
}