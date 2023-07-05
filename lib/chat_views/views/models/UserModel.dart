
class UserModel {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  String? phoneNumber;
  String? fcmToken;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.photoUrl,
    this.phoneNumber,
    this.fcmToken
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone'],
      photoUrl: json['photo'],
      fcmToken: json['fcm_token']??'',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phoneNumber;
    data['photo'] = this.photoUrl;
    data['fcm_token'] = this.fcmToken;
    return data;
  }

}
