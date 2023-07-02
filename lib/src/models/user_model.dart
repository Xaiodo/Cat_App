import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 2)
class UserModel extends Equatable {
  const UserModel({
    this.id,
    this.name,
    this.email,
    this.photoUrl,
  });

  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? photoUrl;

  factory UserModel.empty() => const UserModel(
        id: '',
        name: '',
        email: '',
        photoUrl: '',
      );

  @override
  List<Object?> get props => [id, name, email, photoUrl];
}
