import 'package:estaciona_car/database/car_dao.dart';
import 'package:estaciona_car/models/car.dart';
import 'package:flutter/material.dart';

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
	CarDao carDao = new CarDao();
	List<Car> cars = List();
  Car car = Car();

	@override
  void initState() {
    super.initState();


	  carDao.getAll().then((list) {
      setState(() {
        print(list);
      });
    });
	
  }

  @override
  Widget build(BuildContext context) {
	return ListView.builder(
			padding: EdgeInsets.all(10.0),
			itemCount: cars.length,
			itemBuilder: (context, index) {
				return Text(
					cars[index].name ?? "",
					style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)
				);
			}
		);
  }
}