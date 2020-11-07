import 'package:estaciona_car/views/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
	runApp(MaterialApp(
    	home: HomePage(),
		theme: ThemeData(
			appBarTheme: AppBarTheme(
				centerTitle: true,
				elevation: 0
			)
		),
		debugShowCheckedModeBanner: false
	));
}