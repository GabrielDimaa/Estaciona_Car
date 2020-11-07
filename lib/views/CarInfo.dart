import 'package:estaciona_car/controllers/carController.dart';
import 'package:estaciona_car/models/car.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttericon/web_symbols_icons.dart';

class CarInfo extends StatefulWidget {
	final Car car;

	const CarInfo({this.car});

	@override
	_CarInfoState createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
	CarController carController = CarController();

	Car _car;
	String _name;
	String _board;
	String _color;
	String _owner;
	String _phone;
  String _locale;
	String _time;

	String _timeCounter;
	Timer _timer;
	String _hour = "";
	String _price;
	
	@override
	void initState() { 
	  	super.initState();

		_car = widget.car;
		_name = _car.name;
		_board = _car.board;
		_color = _car.color;
		_owner = _car.owner;
		_phone = _car.phone;
		_locale = _car.locale;
		_time = _car.time;

		String timeCar = _getTimeCar();
		if (timeCar.contains("hora")) {
			timeCar = timeCar.replaceAll("hora", "");
			_timeCounter = _convertTime(double.parse(timeCar));
			_startTimer();
		} else {
			_timeCounter = timeCar;
		}
	}

	void _startTimer() {
		_timer = Timer.periodic(Duration(seconds: 1), (timer) {
			setState(() {
				String minutes;
				String value2;

				if (_timeCounter.length > 6) {
					String aux = _timeCounter.substring(0, 3);
					_timeCounter = _timeCounter.substring(3, _timeCounter.length);

					_hour = "$aux";
				}

				minutes = _timeCounter.substring(0, (_timeCounter.length - 2));
				value2 = _timeCounter.substring((_timeCounter.length - 2), _timeCounter.length);
				
				int seconds = int.parse(value2);

				if (seconds < 59) {
					seconds ++;

					if (seconds < 10){
						_timeCounter = minutes + "0" + seconds.toString();
					} else {
						_timeCounter = minutes + seconds.toString();
					}
				} else {
					int minutes_ = int.parse(_timeCounter.substring(0, (_timeCounter.length - 3)));
					
					seconds = 0;
					minutes_ ++;

					if (minutes_ > 59) {
						timer.cancel();

						String timeCar = _getTimeCar();
						if (timeCar.contains("hora")) {
							timeCar = timeCar.replaceAll("hora", "");
							_timeCounter = _convertTime(double.parse(timeCar));
							_startTimer();
						}
					}

					_timeCounter = "$minutes_:0$seconds";
				}
			});
		});
	}

	String _getTimeCar() {
		DateTime now = DateTime.now();
		String dateNow = _formatDate(now);
		String timeNow = now.toString().substring(11, 19);

		String carTime = _car.time;
		String dateCar = carTime.substring(0, 10);
		String timeCar = carTime.toString().substring(11, 19);

		if (dateNow == dateCar) {
			double now = _convertSeconds(timeNow);
			double time = _convertSeconds(timeCar);

			return (now - time).toString() + "hora";
		} else {
			return "+1 dia(s)";
		}
	}

	void _getPrice() {
		String time = _getTimeCar();
		if (time.contains("hora")) {
			String aux = time.replaceAll("hora", "");
			double seconds = double.parse(aux);
			if (seconds <= 1800) {
				_price = "R\$ 5,00";
			} else if (seconds > 1800 && seconds <= 3600) {
				_price = "R\$ 8,00";
			} else if (seconds > 3600 && seconds <= 5400) {
				_price = "R\$ 10,00";
			} else if (seconds > 5400 && seconds <= 7200) {
				_price = "R\$ 13,00";
			} else {
				_price = "R\$ 17,00";
			}
		} else {
			_price = "R\$ 25,00";
		}
	}

	String _formatDate(date_) {
		String date = date_.toString().substring(0, 10);
		String day = date.substring(8, 10);
		String month = date.substring(5, 7);
		String year = date.substring(0, 4);

		return "$day/$month/$year";
	}

	double _convertSeconds(time) {
		String hour = time.substring(0, 2);
		String minute = time.substring(3, 5);
		String second = time.substring(6, 8);

		double hourInSeconds = (double.parse(hour)) * 3600;
		double minuteInSeconds = (double.parse(minute)) * 60;
		double secondInSeconds = double.parse(second);

		return hourInSeconds + minuteInSeconds + secondInSeconds;
	}

	String _convertTime(seconds) {
		String time;
		String hour_;
		String minutes_;
		String seconds_;
		double minutesMod;
		double secondsMod;

		double minutes = seconds / 60;
		if (minutes >= 60) {
			double hour = minutes / 60;
			hour_ = hour.toInt().toString();

			minutesMod = minutes % 60;
			seconds = minutesMod * 60;

			String aux = hour_.toString();
			aux.length == 1 ? time = "0$aux" : time = aux;

			time = time + ":";
		}
		if (seconds >= 60) {
			double minutes = seconds / 60;
			minutes_ = minutes.toInt().toString();
			
			secondsMod = seconds % 60;
			seconds = secondsMod * 60;
			
			secondsMod = double.parse("0." + seconds.toInt().toString());
			seconds_ = (secondsMod * 60).toInt().toString();
			
			if (time != null) {
				String aux = minutes_.toString();
				aux.length == 1 ? time = "$time:0$aux" : time = time + aux;
				

				time = time + ":";

				aux = seconds_.toString();
				aux.length == 1 ? time = time + "0$aux" : time = time + aux;
			} else {
				String aux = minutes_.toString();
				aux.length == 1 ? time = "0$aux" : time = aux;

				time = time + ":";

				aux = seconds_.toString();
				aux.length == 1 ? time = time + "0$aux" : time = time + aux;
			}
		} else {
			time = seconds.toInt().toString();
		}

		return time;
	}

	void _deleteCar() {
		carController.delete(_car.id);
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Info", style: TextStyle(fontSize: 25)),
				flexibleSpace: Container(
					decoration: BoxDecoration(
						gradient: LinearGradient(
							begin: Alignment.centerLeft,
							end: Alignment.centerRight,
							colors: <Color>[
								Color(0xFF2B0948),
								Color(0xFFCE653B)
							]
						)
					)
				)
			),
			body: Container(
				width: MediaQuery.of(context).size.width,
				height: MediaQuery.of(context).size.height,
				decoration: BoxDecoration(
					gradient: LinearGradient(
						begin: Alignment.centerLeft,
						end: Alignment.centerRight,
						colors: <Color>[
							Color(0xFF2B0948),
							Color(0xFFCE653B)
						]
					)
				),
				child: Container(
					margin: EdgeInsets.only(top: 6.0),
					padding: EdgeInsets.only(top: 20.0, bottom: 10, left: 10, right: 10),
					decoration: BoxDecoration(
						borderRadius: BorderRadius.only(topLeft: Radius.circular(75), topRight: Radius.circular(75)),
						color: Colors.white
					),
					child: Center(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							children: <Widget>[
								Container(
									width: 260.0,
									height: 230.0,
									padding: EdgeInsets.all(27.0),
									decoration: BoxDecoration(
										borderRadius: BorderRadius.circular(120.0),
										gradient: LinearGradient(
											begin: Alignment.topCenter,
											end: Alignment.bottomCenter,
											colors: [
												Color(0xFF2B0948),
												Color(0xFFCE653B)
											]
										)
									),
									child: Column(
										children: <Widget>[
											Text("E$_locale", style: TextStyle(
												fontWeight: FontWeight.w400,
												color: Colors.white,
												fontSize: 35.0
											)),
											Expanded(
												child: Image(
													image: AssetImage('images/carTop.png')
												)
											)
										]
									)
								),
								Container(
									child: Column(
										children: <Widget>[
											textInfo("$_name $_board, $_color"),
											textInfo("$_owner, $_phone"),
											textInfo("$_time")
										]
									)
								),
								Text(
									"$_hour$_timeCounter",
									style: TextStyle(
										fontSize: 45.0,
										color: Colors.black54,
										fontWeight: FontWeight.bold
									)
								),
								RaisedButton(
									onPressed: () {
										_getPrice();
										_showAlertDialog(context);
									},
									shape: RoundedRectangleBorder(
										borderRadius: BorderRadius.circular(30.0)
									),
									textColor: Colors.white,
									padding: EdgeInsets.all(0.0),
									child: Container(
										child: Row(
											mainAxisAlignment: MainAxisAlignment.center,
											children: <Widget>[
												Icon(WebSymbols.ok_circle),
												Text('    Finalizar', style: TextStyle(fontSize: 19))
											]
										),
										alignment: Alignment.center,
										width: 250.0,
										padding: EdgeInsets.all(12.0),
										decoration: BoxDecoration(
											gradient: LinearGradient(
												begin: Alignment.centerLeft,
												end: Alignment.centerRight,
												colors: <Color>[
													Color(0xFF76030F),
													Color(0xFF121B67)
												]
											),
											borderRadius: BorderRadius.all(Radius.circular(30.0))
										)
									)
								)
							]
						),
					)
				)
			)
		);
	}

	_showAlertDialog(BuildContext context) {
		showDialog(
			context: context,
			builder: (BuildContext context) {
				return AlertDialog(
					title: Text(
						"Encerrar Processo!",
						style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
						textAlign: TextAlign.center
					),
					content: Text(
						"Valor: $_price",
						style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.0, color: Color(0xFFAA513E)),
						textAlign: TextAlign.center
					),
					actions: [
						FlatButton(
							child: Text("Voltar", style: TextStyle(
								fontSize: 15.0,
								color: Color(0xFF170B47)
							)),
							onPressed: () {
								Navigator.pop(context);
							}
						),
						FlatButton(
							child: Text("Encerrar", style: TextStyle(
								fontSize: 15.0,
								color: Color(0xFF170B47)
							)),
							onPressed: () {
								_deleteCar();
								Navigator.pop(context);
								Navigator.pop(context);
							}
						)
					]
				);
			}
		);
	}

	Widget textInfo(String text) {
		return Text(
			"$text",
			style: TextStyle(
				fontSize: 21.0,
				color: Colors.grey
			)
		);
	}
}