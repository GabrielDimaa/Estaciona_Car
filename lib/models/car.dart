class Car {
	int id;
	String name; // nome
	String board; // placa
	String color; // cor
	String owner; // proprietário
	String phone; // telefone
  String locale; // local
	String time; // hora

	Car();

	Map toMap() {
		Map<String, dynamic> map = {
			'nameColumn': name,
			'boardColumn': board,
			'colorColumn': color,
			'ownerColumn': owner,
			'phoneColumn': phone,
      'localeColumn': locale,
			'timeColumn': time
		};

		if (id != null) {
			map['idColumn'] = id;
		}

		return map;
	}

	Car.fromMap(Map<String, dynamic> map) {
		id = map['idColumn'];
		name = map['nameColumn'];
		board = map['boardColumn'];
		color = map['colorColumn'];
		owner = map['ownerColumn'];
		phone = map['phoneColumn'];
    locale = map['localeColumn'];
		time = map['timeColumn'];
	}

	@override
	String toString() {
		return "Car(id: $id, name: $name, board: $board, color: $color, owner: $owner, phone: $phone, locale: $locale, time: $time)";
	}
}