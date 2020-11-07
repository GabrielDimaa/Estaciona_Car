import 'package:flutter/material.dart';

class CarsResume extends StatelessWidget {
	final int size;

	const CarsResume({this.size});

	@override
	Widget build(BuildContext context) {
		int available = 20 - this.size;

		return Center(
			child: Card(
				elevation: 10,
				shape: RoundedRectangleBorder(
					borderRadius: BorderRadius.circular(60),
				),
				child: Container(
					padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
					height: 400.0,
					width: 230.0,
					decoration: BoxDecoration(
						borderRadius: BorderRadius.circular(60),
						gradient: LinearGradient(
							begin: Alignment.centerLeft,
							end: Alignment.centerRight,
							colors: [
								Color(0xFF76030F),
								Color(0xFF121B67)
							]
						),
					),
					child: Container(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.spaceBetween,
							children: <Widget>[
								Container(
									child: Column(
										children: <Widget>[
											textCard(text: "Total"),
											textCard(text: "20", date: true)
										]
									)
								),
								Container(
									child: Column(
										children: <Widget>[
											textCard(text: "Ocupadas"),
											textCard(text: "$size", date: true)
										]
									)
								),
								Container(
									child: Column(
										children: <Widget>[
											textCard(text: "Disponíveis"),
											textCard(text: "$available", date: true)
										]
									)
								)
							]
						)
					)
				)
			)
		);
	}

	Widget textCard({String text, bool date}) {
		return Text(
			text,
			style: TextStyle(
				fontSize: date != null ? 50 : 19,
				color: Colors.white,
				fontWeight: date != null ? FontWeight.w900 : FontWeight.w400
			)
		);
	}
}