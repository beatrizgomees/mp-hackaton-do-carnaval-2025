class Bloco {
  int id;
  String title;
  String description;
  DateTime dateTime;
  String address;
  String completeAddress;
  String city;
  String neighboorhood;
  String price;
  String eventUrl;

  Bloco({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.address,
    required this.completeAddress,
    required this.city,
    required this.neighboorhood,
    required this.price,
    required this.eventUrl,
  });

  // Converte um Map para um objeto Bloco
  factory Bloco.fromMap(Map<String, dynamic> map) {
    return Bloco(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dateTime: DateTime.tryParse(map['date_time'] ?? '') ?? DateTime.now(),
      address: map['address'] ?? '',
      completeAddress: map['complete_address'] ?? '',
      city: map['city'] ?? '',
      neighboorhood: map['neighboorhood'] ?? '',
      price: map['price'] ?? '',
      eventUrl: map['event_url'] ?? '',
    );
  }

  // Converte um objeto Bloco para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date_time': dateTime.toIso8601String(),
      'address': address,
      'complete_address': completeAddress,
      'city': city,
      'neighboorhood': neighboorhood,
      'price': price,
      'event_url': eventUrl,
    };
  }
}
