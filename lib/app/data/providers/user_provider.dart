import 'package:trouvetout/app/data/models/address.dart';
import 'package:trouvetout/app/data/models/user.dart';
import 'package:trouvetout/app/data/providers/base_provider.dart';

class UserProvider extends BaseProvider {

  Future<User> auth() async {
    return User(
        email: 'florentin.yao.3344@gmail.com', firstname: 'Florentin', lastname: 'Yao', avatar: 'https://st3.depositphotos.com/1037987/15097/i/600/depositphotos_150975580-stock-photo-portrait-of-businesswoman-in-office.jpg',
      address: Address(
          firstname: 'Florentin',
          lastname: 'Yao',
          city: 'Abidjan',
          address: 'Camp-Millitaire',
          phone: '0787837592'
      )
    );
  }

  Future<void> address() async {

  }

}