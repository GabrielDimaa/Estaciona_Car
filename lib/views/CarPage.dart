import 'package:estaciona_car/controllers/carController.dart';
import 'package:estaciona_car/models/car.dart';
import 'package:flutter/material.dart';
import 'package:mask_shifter/mask_shifter.dart';

class CarPage extends StatefulWidget {
	final int id;
	final Car car;

	const CarPage({this.id, this.car});

	@override
	_CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {
	GlobalKey<FormState> _formKey = GlobalKey<FormState>();
	TextEditingController _name = TextEditingController();
	TextEditingController _board = TextEditingController();
	TextEditingController _color = TextEditingController();
	TextEditingController _owner = TextEditingController();
	TextEditingController _phone = TextEditingController();
	TextEditingController _locale = TextEditingController();

	List<Car> _listCar = List();

	@override
	void initState() {
		super.initState();

		_getAllCars();

		if (widget.id != null) {
			int id_ = (int.parse(widget.id.toString())) + 1;
			_locale.text = "E$id_";
		}
	}

	bool _hasCarInLot(String locale) {
		for(Car car in _listCar) {
			if (car.locale == locale) {
				return false;
			}
		}

		return true;
	}

  	void _getAllCars() {
    	CarController carController = CarController();
		carController.getAll().then((list) {
			setState(() {
				_listCar = list;
			});
		});
	}

	void _insert() {
		String time = _getTime();

		String _localeConvert = _locale.text.toString().toUpperCase().replaceAll("E", "");
		int _localeInt = int.parse(_localeConvert);
		// if (_localeInt > 10) {
		// 	return ""
		// }

		if (_hasCarInLot(_localeInt.toString())) {
			Car car = Car();
			car.name = _name.text;
			car.board = _board.text;
			car.color = _color.text;
			car.owner = _owner.text;
			car.phone = _phone.text;
			car.locale = _localeInt.toString();
			car.time = time;

			CarController carController = CarController();
			carController.insert(car);
		}
	}

	String _getTime() {
		DateTime now = DateTime.now();

		String date = now.toString().substring(0, 10);
		String day = date.substring(8, 10);
		String month = date.substring(5, 7);
		String year = date.substring(0, 4);

		String hour = now.toString().substring(11, 19);
		String time = "$day/$month/$year $hour";
		
		return time;
	}

    @override
    Widget build(BuildContext context) {
        return WillPopScope(
			// onWillPop: ,
			child: Container(
				decoration: BoxDecoration(
					gradient: LinearGradient(
						begin: Alignment.topCenter,
						end: Alignment.bottomRight,
						colors: <Color>[
							Color(0xFF2B0948),
							Color(0xFFCE653B)
						]
					)
				),
				child: Scaffold(
					backgroundColor: Colors.transparent,
					appBar: AppBar(
						title: widget.id != null ? Text("Editar Veículo") : Text("Inserir Veículo"),
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
						),
						centerTitle: true
					),
					floatingActionButton: FloatingActionButton.extended(
						onPressed: () async {
							if (_formKey.currentState.validate()) {
								_insert();
								await Navigator.pop(context);
							}
						},
						icon: Icon(Icons.thumb_up),
						label: Text('Confirmar'),
						elevation: 10.0,
						backgroundColor: Color(0xFF72351D)
					),
					floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
					body: SingleChildScrollView(
						padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 80.0),
						child: Form(
							key: _formKey,
							child: Column(
								children: <Widget>[
									textFormField(
										controller: _name, 
										error: "Insira o nome do véiculo", 
										label: "Nome do Veículo"
									),
									textFormField(
										controller: _board, 
										error: "Insira a placa", 
										label: "Placa"
									),
									textFormField(
										controller: _color,
										error: "Insira a cor", 
										label: "Cor"
									),
									textFormField(
										controller: _owner, 
										error: "Insira o proprietário do veículo", 
										label: "Proprietário"
									),
									textFormField(
										controller: _phone, 
										error: "Insira a telefone", 
										label: "Telefone",
										keyBoard: true
									),
									textFormField(
										controller: _locale, 
										error: "Insira o local do veículo", 
										label: "Local",
										keyBoard: true,
										local: true
									)
								]
							)
						)
					)
				)
			)
		);
    }

	Widget textFormField(
		{TextEditingController controller, String error, 
		String label, bool keyBoard, bool local}) {
			return Container(
				margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
				width: 230.0,
				height: 50.0,
				child: TextFormField(
					keyboardType: keyBoard != null ? TextInputType.number : TextInputType.text,
					style: TextStyle(color: Colors.white, fontSize: 17),
					textAlign: TextAlign.center,
					decoration: InputDecoration(
						contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
						labelText: label,
						labelStyle: TextStyle(
							color: Colors.white.withOpacity(0.7),
							fontSize: 18.0,
						),
						border: OutlineInputBorder(
							borderSide: BorderSide(color: Colors.white, width: 2.0),
							borderRadius: BorderRadius.all(Radius.circular(15.0)),
						),
						enabledBorder: OutlineInputBorder(
							borderSide: BorderSide(color: Colors.white, width: 2.0),
							borderRadius: BorderRadius.all(Radius.circular(15.0))
						),
						focusedBorder: OutlineInputBorder(
							borderSide: BorderSide(color: Colors.white, width: 2.0),
							borderRadius: BorderRadius.all(Radius.circular(15.0))
						),
					),
					validator: (text) {
						return text.isEmpty ? error : null;
					},
					inputFormatters: [
						local != null ? MaskedTextInputFormatterShifter(
                      		maskONE: "E-X", 
							maskTWO: "E-XX"
						) : MaskedTextInputFormatterShifter(
							maskONE: "XXXXXXXXXXXXXXXXXX", 
							maskTWO: "XXXXXXXXXXXXXXXXXX"
						)
					],
					controller: controller
				)
			);
	}
}