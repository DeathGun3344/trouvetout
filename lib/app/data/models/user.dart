
import 'package:trouvetout/app/data/models/address.dart';

class User {
  final String email;
  final String firstname;
  final String lastname;
  final String avatar;
  Address? address;

  String get name => "$lastname $firstname";

  User({required this.email, required this.firstname, required this.lastname, required this.avatar, this.address});
  //TODO: Verifier la clé billing
  factory User.fromJson(Map<String, dynamic> json) => User(address: json['billing'] != null ? Address.fromJson(json['billing']) : null, email: json['email'], firstname: json['first_name'], lastname: json['last_name'], avatar: json['avatar_url']);

}