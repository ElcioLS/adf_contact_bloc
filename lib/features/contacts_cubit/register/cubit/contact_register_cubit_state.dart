part of 'contact_register_cubit.dart';

@freezed
class ContactRegisterCubitState with _$ContactRegisterCubitState {
  factory ContactRegisterCubitState.initial() = _Initial;
  factory ContactRegisterCubitState.loading() = _loading;
  factory ContactRegisterCubitState.success() = _Success;
  factory ContactRegisterCubitState.error({required String message}) = _Error;
  factory ContactRegisterCubitState.save({
    required String name,
    required String email,
  }) = _Save;
}
