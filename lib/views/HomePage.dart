import 'package:estaciona_car/components/itemAppBar.dart';
import 'package:estaciona_car/controllers/carController.dart';
import 'package:estaciona_car/models/car.dart';
import 'package:estaciona_car/views/CarList.dart';
import 'package:estaciona_car/views/CarPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

class HomePage extends StatefulWidget {
	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
	final _tabs = ['Home', 'Resumo', 'Vagas', 'Preço'];
	int _selectedPosition = 0;

	CarController _carController = CarController();
	List<Car> _listCar = List();
	Car _checked;

	@override
	initState() { 
	  	super.initState();

		setState(() {
			_getAllCars();
		});
	}

	void _getAllCars() {
		_carController.getAll().then((list) {
			setState(() {
				_listCar = list;
			});
		});
	}

	Car checkLot(int index) {
		int id_ = index + 1;
		id_.toString();

		for(int i = 0; i < _listCar.length; i++) {
			if (_listCar[i].locale == id_.toString()) {
				return _listCar[i];
			}
		}

		return null;
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(_tabs[_selectedPosition]),
				centerTitle: true,
				flexibleSpace: Container(
					decoration: BoxDecoration(
						gradient: LinearGradient(
							begin: Alignment.topLeft,
							end: Alignment.bottomRight,
							colors: <Color>[
								Color(0xFF2B0948),
								Color(0xFFCE653B)
							]
						)
					)
				)
			),
			floatingActionButton: FloatingActionButton(
				onPressed: () async {
					await Navigator.push(context, MaterialPageRoute(
						builder: (context) => CarPage()
					));
					setState(() {
						_getAllCars();
					});
				},
				child: Icon(Icons.add),
				elevation: 10.0,
				backgroundColor: Color(0xFFCE653B)
			),
			floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
			bottomNavigationBar: BottomAppBar(
				color: Colors.white,
				shape: CircularNotchedRectangle(),
				child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: <Widget>[
						ItemAppBar(text: _tabs[0], icon: Icons.home, isSelected: _selectedPosition == 0, onTap: () {
							setState(() => _selectedPosition = 0);
						}),
						ItemAppBar(text: _tabs[1], icon: Icons.apps, isSelected: _selectedPosition == 1, onTap: () {
							setState(() => _selectedPosition = 1);
						}),
						SizedBox(width: 40.0),
						ItemAppBar(text: _tabs[2], icon: Icons.local_parking, isSelected: _selectedPosition == 2, onTap: () {
							setState(() => _selectedPosition = 2);
						}),
						ItemAppBar(text: _tabs[3], icon: Entypo.tag, isSelected: _selectedPosition == 3, onTap: () {
							setState(() => _selectedPosition = 3);
						})
					]
				)
			),
			body: SingleChildScrollView(
				padding: EdgeInsets.all(10.0),
				child: Container(
					child: IndexedStack( 
						index: _selectedPosition,
						children: <Widget>[
							Container(
								padding: EdgeInsets.only(bottom: 200.0),
								width: MediaQuery.of(context).size.width,
								height: MediaQuery.of(context).size.height,
								child: GridView.builder(
									gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
										crossAxisCount: 2,
										childAspectRatio: MediaQuery.of(context).size.width / 
											(MediaQuery.of(context).size.height / 4)
									),
									itemCount: 20,
									itemBuilder: (context, index) {
										_checked = checkLot(index);
										return GridTile(
											child: 
											_checked != null && index % 2 == 0 ? 
												CarList(index: index, car: _checked, onTap: () {_getAllCars();}) : 
											_checked != null ? 
												CarList(side: true, index: index, car: _checked, onTap: () {_getAllCars();}) :
											index % 2 == 0 ?
												CarList(index: index, onTap: () {_getAllCars();}) :
												CarList(side: true, index: index, onTap: () {_getAllCars();})
										);
									}
								)
							),
							Container(
								width: MediaQuery.of(context).size.width * 1,
								height: MediaQuery.of(context).size.height * 1
							),
							Container(
								color: Colors.amber, 
								width: MediaQuery.of(context).size.width * 1,
								height: MediaQuery.of(context).size.height * 1
							),
							Container(
								color: Colors.purple, 
								width: MediaQuery.of(context).size.width * 1,
								height: MediaQuery.of(context).size.height * 1
							)
						]
					)
				)
			)
		);
	}
}