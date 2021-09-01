import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/auth_bloc.dart';
import 'package:water/domain/model/profile/address_translation_form.dart';
import 'package:water/domain/model/profile/profile_form.dart';
import 'package:water/domain/service/profile_service.dart';
import 'package:water/locator.dart';
import 'package:water/util/nullable.dart';
import 'package:water/util/session.dart';

part 'profile_event.dart';
part 'profile_state.dart';

extension BlocGetter on BuildContext {
  ProfileBloc get profile => this.read<ProfileBloc>();
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required AuthBloc auth})
      : super(
          ProfileState(
            familyMembersCount: 0,
            referralCode: 0,
            walletBalance: 0.0,
          ),
        ) {
    _authStateSubscription = auth.stream.listen((state) {
      if (state is Authenticated) {
        add(LoadProfile());
      } else if (state is Unauthenticated) {
        add(ClearProfile());
      }
    });
  }

  final ProfileService _profileService = locator<ProfileService>();

  late final StreamSubscription _authStateSubscription;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadProfile) {
      yield* _mapLoadProfileToState();
    } else if (event is SaveProfile) {
      yield* _mapSaveProfileToState(event);
    } else if (event is ClearProfile) {
      yield* _mapClearProfileToState();
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription.cancel();
    return super.close();
  }

  Stream<ProfileState> _mapLoadProfileToState() async* {
    if (Session.isAuthenticated) {
      print('load profile');

      yield state.copyWith(status: ProfileStatus.loading);

      final profile = await _profileService.getByToken(Session.token!);

      DateTime? birthday;
      if (profile.birthday != null) {
        birthday = DateFormat('yyyy-MM-ddTHH:mm:ss').parse(profile.birthday!);
      }

      yield state.copyWith(
        firstName: Nullable(profile.firstName),
        lastName: Nullable(profile.lastName),
        email: Nullable(profile.email),
        phoneNumber: Nullable(profile.phoneNumber),
        birthday: Nullable(birthday),
        nationality: Nullable(profile.nationality),
        city: Nullable(profile.city),
        district: Nullable(profile.district),
        street: Nullable(profile.street),
        building: Nullable(profile.building),
        apartment: Nullable(profile.apartment),
        floor: Nullable(profile.floor),
        familyMembersCount: profile.familyMembersCount,
        referralCode: profile.referralCode,
        walletBalance: profile.walletBalance,
        status: ProfileStatus.loaded,
      );
    }
  }

  Stream<ProfileState> _mapSaveProfileToState(
    SaveProfile event,
  ) async* {
    if (Session.isAuthenticated) {
      print('save profile');

      yield state.copyWith(status: ProfileStatus.saving);

      String? birthday;
      if (event.birthday != null) {
        birthday = DateFormat('yyyy-MM-ddTHH:mm:ss').format(event.birthday!);
      }

      final form = ProfileForm(
        firstName: event.firstName,
        lastName: event.lastName,
        phoneNumber: event.phoneNumber,
        birthday: birthday,
        familyMembersCount: event.familyMembersAmount,
        nationality: event.nationality,
        addressTranslations: [
          AddressTranslationForm(
            language: event.language,
            city: event.city,
            district: event.district,
            street: event.street,
            building: event.building,
            apartment: event.apartment,
            floor: event.floor,
          ),
        ],
      );
      await _profileService.save(Session.token!, form);

      yield state.copyWith(
        firstName: Nullable(event.firstName),
        lastName: Nullable(event.lastName),
        phoneNumber: Nullable(event.phoneNumber),
        birthday: Nullable(event.birthday),
        nationality: Nullable(event.nationality),
        city: Nullable(event.city),
        district: Nullable(event.district),
        street: Nullable(event.street),
        building: Nullable(event.building),
        apartment: Nullable(event.apartment),
        floor: Nullable(event.floor),
        familyMembersCount: event.familyMembersAmount,
        status: ProfileStatus.saved,
      );
    }
  }

  Stream<ProfileState> _mapClearProfileToState() async* {
    print('clear profile');

    yield state.copyWith(
      firstName: Nullable(null),
      lastName: Nullable(null),
      email: Nullable(null),
      phoneNumber: Nullable(null),
      birthday: Nullable(null),
      nationality: Nullable(null),
      city: Nullable(null),
      district: Nullable(null),
      street: Nullable(null),
      building: Nullable(null),
      apartment: Nullable(null),
      floor: Nullable(null),
      familyMembersCount: 0,
      referralCode: 0,
      walletBalance: 0.0,
      status: ProfileStatus.none,
    );
  }
}
