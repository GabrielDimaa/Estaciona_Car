import 'package:estaciona_car/models/car.dart';
import 'package:estaciona_car/views/CarInfo.dart';
import 'package:estaciona_car/views/CarPage.dart';
import 'package:estaciona_car/views/HomePage.dart';
import 'package:flutter/material.dart';

class CarList extends StatefulWidget {
	final Function onTap;
	final bool side;
	final int index;
  	final Car car;

	const CarList({this.onTap, this.side, this.index, this.car});

	@override
	_CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			child: Container(
				margin: widget.side != null ? 
					EdgeInsets.only(top: 10, left: 40, bottom: 10, right: 10) :
					EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 40),
				height: 50.0,
				decoration: BoxDecoration(
					border: Border(
						right: widget.side != null ? 
						BorderSide(
							color: Colors.grey[400],
							width: 1.5
						) : BorderSide(
							color: Colors.transparent,
							width: 0
						),
						top: BorderSide(
							color: Colors.grey[400],
							width: 1.5
						),
						left: widget.side == null ? 
						BorderSide(
							color: Colors.grey[400],
							width: 1.5
						) : BorderSide(
							color: Colors.transparent,
							width: 0
						),
						bottom: BorderSide(
							color: Colors.grey[400],
							width: 1.5
						)
					)
				),
				child: Column(
					children: <Widget>[
						Expanded(
							child: Padding(
								padding: const EdgeInsets.all(8.0),
								child: widget.car != null  ? Image(
									image: widget.side != null ? 
										AssetImage('images/carRight.png') :
										AssetImage('images/carLeft.png')
								) : Container()
							)
						)
					]
				)
			),
			onTap: () async {
				await Navigator.push(context, MaterialPageRoute(
					builder: (context) => widget.car != null ? 
						CarInfo(car: widget.car) :
						CarPage(id: widget.index)
				));
				setState(() => widget.onTap());
			}
		);
	}
}