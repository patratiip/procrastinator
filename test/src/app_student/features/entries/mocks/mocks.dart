@GenerateMocks([
  IEntryRepository,
  IEntryDataProvider,
  CollectionReference,
  DocumentReference,
  QuerySnapshot,
  QueryDocumentSnapshot,
])
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mockito/annotations.dart';
import 'package:procrastinator/src/app_student/features/entries/data/entry_repository.dart';
import 'package:procrastinator/src/app_student/features/entries/data/firebase_entry_data_provider.dart';
