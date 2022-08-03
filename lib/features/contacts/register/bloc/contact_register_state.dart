part of 'contact_register_bloc.dart';

@freezed
class ContactRegisterState with _$ContactRegisterState {
  factory ContactRegisterState.initial() = _Initial;
  factory ContactRegisterState.loading() = _Loading;
  factory ContactRegisterState.success() = _Success;
  factory ContactRegisterState.error({required String message}) = _Error;
}
