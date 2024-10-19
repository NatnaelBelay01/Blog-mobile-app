import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class InternetChecker {
  Future get isConnected;
}

class InternetCheckerImpl implements InternetChecker {
  final InternetConnection checker;
  InternetCheckerImpl({required this.checker});

  @override
  Future get isConnected async => await checker.hasInternetAccess;
}
