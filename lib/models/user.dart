class UserModel {
  final String uid;
  final String? name;
  final int? age;
  final String? profession;
  final String? gender;

  UserModel({
    required this.uid,
    this.name,
    this.age,
    this.profession,
    this.gender,
  });

  // Convert Firestore doc to UserModel
  factory UserModel.fromMap(String uid, Map<String, dynamic> data) {
    return UserModel(
      uid: uid,
      name: data['name'] as String?,
      age: data['age'] is int
          ? data['age'] as int
          : int.tryParse(data['age']?.toString() ?? ''),
      profession: data['profession'] as String?,
      gender: data['gender'] as String?,
    );
  }

  // Convert UserModel to map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'profession': profession,
      'gender': gender,
    };
  }
}
