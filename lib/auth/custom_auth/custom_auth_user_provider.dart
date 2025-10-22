import 'package:rxdart/rxdart.dart';

import '/backend/schema/structs/index.dart';
import 'custom_auth_manager.dart';

class HROptimisticMobileAuthUser {
  HROptimisticMobileAuthUser({
    required this.loggedIn,
    this.uid,
    this.userData,
  });

  bool loggedIn;
  String? uid;
  UserStruct? userData;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<HROptimisticMobileAuthUser> hROptimisticMobileAuthUserSubject =
    BehaviorSubject.seeded(HROptimisticMobileAuthUser(loggedIn: false));
Stream<HROptimisticMobileAuthUser> hROptimisticMobileAuthUserStream() =>
    hROptimisticMobileAuthUserSubject
        .asBroadcastStream()
        .map((user) => currentUser = user);
