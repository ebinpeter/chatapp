class UserModel {
  String? name;
  String? phone;
  String? uid;
  String? proImg;


  UserModel({this.name, this.phone, this.uid, this.proImg});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String?,
      phone: map['phone'] as String?,
      uid: map['uid'] as String?,
      proImg: map['proImg'] as String?,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'uid': uid,
      'proImg': proImg,
    };
  }

  // Override toString for easier debugging
  @override
  String toString() {
    return 'UserModel{name: $name, phone: $phone, uid: $uid, proImg: $proImg}';
  }
}
