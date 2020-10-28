import 'package:estaciona_car/database/car_dao.dart';
import 'package:estaciona_car/models/car.dart';

class CarController {
	final CarDao carDao = CarDao();

	void insert(Car car) {
		carDao.insert(car);
  }

	Future<List> getAll() {
		final list = carDao.getAll();
		return list;
	}

	Future<Car> getById(int id) {
		final car = carDao.getById(id);
		return car;
	}

	void update(Car car) {
		carDao.update(car);
	}

	void delete(int id) {
		carDao.delete(id);
	}

	Future<int> count() {
		final total = carDao.count();
		return total;
	}
}