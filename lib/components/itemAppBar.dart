import 'package:flutter/material.dart';

class ItemAppBar extends StatelessWidget {
	final String text;
	final IconData icon;
	final bool isSelected;
	final Function onTap;

	const ItemAppBar({Key key, this.text, this.icon, this.isSelected, this.onTap}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return InkWell(
			child: Padding(
			padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 10.0),
				child: Column(
					mainAxisSize: MainAxisSize.min,
					children: <Widget>[
						Icon(icon, color: isSelected ? Color(0xFFCE653B) : Color(0xFF2B0948)),
						Text(text, style: TextStyle(
							color: isSelected ? Color(0xFFCE653B) : Color(0xFF2B0948),
							fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
							fontSize: 12.0
						))
					]
				)
			),
			onTap: onTap
		);
	}
}