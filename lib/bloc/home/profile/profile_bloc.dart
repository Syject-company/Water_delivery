import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/service/profile_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/session.dart';

part 'profile_event.dart';
part 'profile_state.dart';

extension BlocGetter on BuildContext {
  ProfileBloc get profile => this.read<ProfileBloc>();
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(
          ProfileState(
            email: '',
            familyMembersCount: 0,
            referralCode: 0,
            walletBalance: 0.0,
          ),
        );

  final ProfileService _profileService = locator<ProfileService>();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadProfile) {
      yield* _mapLoadProfileToState();
    }
  }

  Stream<ProfileState> _mapLoadProfileToState() async* {
    print('load profile');

    if (Session.isAuthenticated) {
      final profile = await _profileService.getByToken(Session.token!);

      print(profile);

      yield state.copyWith(
        firstName: profile.firstName,
        lastName: profile.lastName,
        email: profile.email,
        phoneNumber: profile.phoneNumber,
        birthday: profile.birthday,
        nationality: profile.nationality,
        city: profile.city,
        district: profile.district,
        street: profile.street,
        building: profile.building,
        apartment: profile.apartment,
        floor: profile.floor,
        familyMembersCount: profile.familyMembersCount,
        referralCode: profile.referralCode,
      );
    }
  }
}
