import 'package:rxdart/rxdart.dart';

import '/backend/schema/structs/index.dart';

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

/// Current authenticated user
HROptimisticMobileAuthUser? currentUser;

/// Generates a stream of the authenticated user.
BehaviorSubject<HROptimisticMobileAuthUser> hROptimisticMobileAuthUserSubject =
    BehaviorSubject.seeded(HROptimisticMobileAuthUser(loggedIn: false));
Stream<HROptimisticMobileAuthUser> hROptimisticMobileAuthUserStream() =>
    hROptimisticMobileAuthUserSubject
        .asBroadcastStream()
        .map((user) => currentUser = user);
