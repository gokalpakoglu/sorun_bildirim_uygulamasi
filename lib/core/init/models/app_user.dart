class AppUser {
  final String email;
  final String password;
  final String name;
  final String surname;
  final double lat;
  final double lng;

  AppUser(
      {required this.email,
      required this.password,
      required this.name,
      required this.surname,
      required this.lat,
      required this.lng});
  @override
  String toString() {
    return "Email: $email\nPassword: $password\nName:$name\nSurname:$surname\nLat:$lat\nLng:$lng";
  }
}
