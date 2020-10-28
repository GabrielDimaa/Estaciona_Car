import 'package:flutter/material.dart';

class CarInfo extends StatefulWidget {
	@override
	_CarInfoState createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Info"),
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
			)
		);
	}
}