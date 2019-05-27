import 'dart:async';
import 'package:algolia/algolia.dart';

class AlgoliaRepository {

  final Algolia algolia;

  AlgoliaRepository({Algolia algolia})
      : algolia = algolia ?? Algolia.init(applicationId: "LJ5RB82WYM",
      apiKey: "0e54c75a00a0ce3e6eb630873b573c25"
  );

  Future<AlgoliaQuerySnapshot> searchIndex(String index, String query) async {

    AlgoliaQuery algoliaQuery = algolia.instance.index(index).search(query);

    return await algoliaQuery.getObjects();
  }

}