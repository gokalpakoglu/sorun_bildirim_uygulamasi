class AppUser {
  final String? email;
  final String? password;
  final String? name;
  final String? surname;
  final double? lat;
  final double? lng;

  AppUser(
      {this.email, this.password, this.name, this.surname, this.lat, this.lng});
  @override
  String toString() {
    return "Email: $email\nPassword: $password\nName:$name\nSurname:$surname\nLat:$lat\nLng:$lng";
  }
}
