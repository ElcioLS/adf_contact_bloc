part of 'contact_update_cubit.dart';

@freezed
class ContactUpdateCubitState with _$ContactUpdateCubitState {
  factory ContactUpdateCubitState.initial() = _Initial;
  factory ContactUpdateCubitState.loading() = _Loading;
  factory ContactUpdateCubitState.error({required String message}) = _Error;
  factory ContactUpdateCubitState.success() = _Success;
  // factory ContactUpdateCubitState.save({
  //   String? id,
  //   required String name,
  //   required String email,
  // }) = _Save;
}
