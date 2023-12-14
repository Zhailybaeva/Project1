import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ok_edus_kz/features/profile_screen/profile_bloc/profile_event.dart';
import 'package:ok_edus_kz/features/profile_screen/profile_bloc/profile_state.dart';
import 'package:ok_edus_kz/model/profile_model.dart';
import 'package:ok_edus_kz/features/profile_screen/repo/profile_repo.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoadingState()) {
    on<FetchProfileEvent>(_mapFetchProfileEventToState);
  }

  Future<void> _mapFetchProfileEventToState(FetchProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      final profileData = await ProfileRepo().fetchProfileData();
      if (profileData != null) {
        final List<Profile> profiles = profileData.map((profileJson) => Profile.fromJson(profileJson)).toList();
        emit(ProfileLoadedState(profiles));
      } else {
        emit(ProfileErrorState("Invalid data format"));
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
}
