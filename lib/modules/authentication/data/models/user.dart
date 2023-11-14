import 'dart:convert';

class AppUser {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? emailAddress;
  AppUser({this.firstName, this.lastName, this.emailAddress, this.phoneNumber});
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      emailAddress:
          map['emailAddress'] != null ? map['emailAddress'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());
}
