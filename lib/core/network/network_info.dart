import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Simple NetworkInfo utility used by repositories to check connectivity.
abstract class NetworkInfo {
	/// Returns true if the device has an internet connection.
	Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
	final InternetConnectionChecker _checker;

	NetworkInfoImpl({InternetConnectionChecker? checker}) : _checker = checker ?? InternetConnectionChecker();

	@override
	Future<bool> get isConnected => _checker.hasConnection;
}
