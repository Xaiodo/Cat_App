part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState({required this.user});

  final UserModel user;

  @override
  List<Object> get props => [user];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial({required super.user});
}

class ProfileLoading extends ProfileState {
  const ProfileLoading({required super.user});
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({required super.user});
}
