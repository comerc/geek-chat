import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class GeekChatFirebaseUser {
  GeekChatFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

GeekChatFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<GeekChatFirebaseUser> geekChatFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<GeekChatFirebaseUser>(
            (user) => currentUser = GeekChatFirebaseUser(user));
