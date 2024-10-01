// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:fund/config/app_strings.dart';
// import 'package:fund/logic/repos/auth/auth_repo.dart';
// import 'package:fund/utils/show_toast.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// Future<T?> excuteAndHandleError<T>({
//   required Future<T?> Function() excute,
//   required Function(String message) onError,
//   bool dataRequired = true,
// }) async {
//   try {
//     final model = await excute.call();
//     return model;
//   } catch (e, t) {
//     debugPrint(e.toString());
//     debugPrint(t.toString());
//     if (e is DioException) {
//       if (e.response?.statusCode == 401) {
//         showToast(msg: "You are not logged in");
//         AuthRepository.logout();
//       }
//       onError
//           .call(e.response?.data['message'] ?? AppStrings.somethingWentWrong);
//       debugPrint(e.response?.data['message']);
//       return null;
//     }
//     onError.call(AppStrings.somethingWentWrong);
//     return null;
//   }
// }
//
// Future<T?> excuteAndHandleListError<T>({
//   required Future<T?> Function() excute,
//   required Function(String message) onError,
//   bool dataRequired = true,
// }) async {
//   try {
//     final model = await excute.call();
//     return model;
//   } catch (e, t) {
//     debugPrint(e.toString());
//     debugPrint(t.toString());
//     if (e is DioException) {
//       if (e.response?.statusCode == 401) {
//         showToast(msg: "You are not logged in");
//         AuthRepository.logout();
//       }
//       onError
//           .call(e.response?.data['message'] ?? AppStrings.somethingWentWrong);
//       debugPrint(e.response?.data['message']);
//       return null;
//     }
//     onError.call(AppStrings.somethingWentWrong);
//     return null;
//   }
// }
//
// Future<void> excuteAndHandleVoidError<T>({
//   required Future<T?> Function() excute,
//   required Function(T? message) onSuccess,
//   required Function(String message) onError,
// }) async {
//   try {
//     final model = await excute.call();
//     await onSuccess.call(model);
//   } catch (e, t) {
//     debugPrint(e.toString());
//     debugPrint(t.toString());
//     if (e is DioException) {
//       if (e.response?.statusCode == 401) {
//         showToast(msg: "You are not logged in");
//         AuthRepository.logout();
//       }
//       onError
//           .call(e.response?.data['message'] ?? AppStrings.somethingWentWrong);
//       debugPrint(e.response?.data['message']);
//     }
//     onError.call(AppStrings.somethingWentWrong);
//   }
// }
//
// Future<void> excuteBlocAndHandleError({
//   required Future<void> Function() execute,
//   required Function(String msg) onError,
//   required Function(String msg) onNetwork,
//   bool online = true,
// }) async {
//   try {
//     if (online) {
//       bool networkStatus = await InternetConnectionChecker().hasConnection;
//       if (!networkStatus) {
//         onNetwork.call(AppStrings.checkInternetAndTryAgain);
//         return;
//       }
//     }
//     await execute.call();
//   } catch (e, t) {
//     debugPrint(e.toString());
//     debugPrint(t.toString());
//     onError.call(AppStrings.somethingWentWrong);
//   }
// }
