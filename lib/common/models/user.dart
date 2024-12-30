
class User {
  final String uid;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? photoURL;
  final String? gender;
  final DateTime? birthdate;

  User({
    required this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.address,
    this.photoURL,
    this.gender,
    this.birthdate,
  });

  factory User.fromFirebaseUser(User firebaseUser, {String? gender, DateTime? birthdate, required String address}) {
    return User(
      uid: firebaseUser.uid,
      displayName: firebaseUser.displayName,
      email: firebaseUser.email,
      phoneNumber: firebaseUser.phoneNumber,
      address: firebaseUser.address,
      photoURL: firebaseUser.photoURL,
      gender: gender,
      birthdate: birthdate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'photoURL': photoURL,
      'gender': gender,
      'birthdate': birthdate?.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      displayName: map['displayName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      photoURL: map['photoURL'],
      gender: map['gender'],
      birthdate: map['birthdate'] != null ? DateTime.parse(map['birthdate']) : null,
    );
  }
}
