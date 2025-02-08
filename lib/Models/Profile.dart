import 'Permissions.dart';

class Profile
{
  late int id;
  late String firstname;
  late String lastname;
  late String email;
  late String mobile;
  late List<Permissions> permission;

  Profile(
    {
      required this.id,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.mobile,
      required this.permission,
    }
  );
}