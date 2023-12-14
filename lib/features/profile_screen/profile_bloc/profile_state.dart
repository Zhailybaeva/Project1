import 'package:equatable/equatable.dart';
import 'package:ok_edus_kz/model/profile_model.dart';


abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final List<Profile> profile;

  ProfileLoadedState(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState(this.error);

  @override
  List<Object?> get props => [error];
}