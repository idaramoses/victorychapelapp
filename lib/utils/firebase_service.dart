import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  FirebaseDatabase getDatabase() {
    FirebaseDatabase database;
    database = FirebaseDatabase.instance;
    database.goOnline();
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    return database;
  }

  DatabaseReference getReference() {
    DatabaseReference ref = getDatabase().reference();
    ref.keepSynced(true);
    return ref;
  }
}
