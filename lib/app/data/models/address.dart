
class Address {
  final String firstname;
  final String lastname;
  final String city;
  final String address;
  final String phone;

  String get name => '$lastname $firstname';

  Address({required this.firstname, required this.lastname, required this.city, required this.address, required this.phone});

  factory Address.fromJson(Map<String, dynamic> json) => Address(phone: json['phone'], firstname: json['first_name'], lastname: json['last_name'], city: json['city'], address: json['address_1']);

  static List<Address> fromList(List list) => list.map((e) => Address.fromJson(e)).toList();

}