import 'wallet.dart';

class User {
  final int id;
  String firstName, lastName;
  String? avatar, email, phoneNumber;
  final Wallet wallet;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User(
      {required this.id,
      this.avatar,
      required this.firstName,
      required this.lastName,
      this.email,
      this.phoneNumber,
      required this.wallet,
      required this.createdAt,
      this.updatedAt,
      this.isActive = true});
  // :assert(email != null || phoneNumber != null);

  String get fullName => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> data) => User(
        id: data['id'],
        avatar: data['avatar'],
        firstName: data['first_name'],
        lastName: data['last_name'],
        email: data['email'],
        phoneNumber: data['phone_number'],
        wallet: Wallet.fromJson(data['wallet']),
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
        isActive: data['is_active'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phoneNumber,
        'wallet': wallet.toJson(),
        'created_at': createdAt,
        'updated_at': updatedAt,
        'is_active': isActive,
      };

  Future<List<User>> getFavorites() async {
    return Future.delayed(const Duration(seconds: 5), () => <User>[]);
  }
}
