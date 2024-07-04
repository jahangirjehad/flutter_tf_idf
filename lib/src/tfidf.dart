import 'dart:math' as math;

import 'package:flutter_tf_idf/flutter_tf_idf.dart';

class TfIdf {
  final List<Document> documents;
  late List<String> terms;
  late List<List<double>> tfIdfMatrix;
  late Map<String, int> termToIndex;
  late Map<String, int> docToIndex;

  TfIdf(this.documents) {
    _calculateTfIdfMatrix();
  }

  void _calculateTfIdfMatrix() {
    var allTerms = <String>{};
    var docTermCounts = <Map<String, int>>[];

    // Count terms in each document
    for (var doc in documents) {
      var termCounts = _getWordCounts(doc.content);
      docTermCounts.add(termCounts);
      allTerms.addAll(termCounts.keys);
    }

    terms = allTerms.toList()..sort();
    termToIndex = {for (var i = 0; i < terms.length; i++) terms[i]: i};
    docToIndex = {
      for (var i = 0; i < documents.length; i++) documents[i].id: i
    };

    // Calculate IDF
    var idfScores = <double>[];
    for (var term in terms) {
      var docCount =
          docTermCounts.where((counts) => counts.containsKey(term)).length;
      var idf = math.log(documents.length / docCount) / math.ln10;
      idfScores.add(idf);
    }

    // Calculate TF-IDF Matrix
    tfIdfMatrix =
        List.generate(documents.length, (_) => List.filled(terms.length, 0.0));
    for (var i = 0; i < documents.length; i++) {
      var termCounts = docTermCounts[i];
      var totalTerms = termCounts.values.reduce((a, b) => a + b);
      for (var j = 0; j < terms.length; j++) {
        var tf = (termCounts[terms[j]] ?? 0) / totalTerms;
        var tfidf = tf * idfScores[j];
        tfIdfMatrix[i][j] =
            tfidf.abs() < 1e-10 ? 0 : tfidf; // Set very small values to 0
      }
    }
  }

  Map<String, int> _getWordCounts(String content) {
    var words = _tokenize(content);
    return words.fold<Map<String, int>>({}, (map, word) {
      map[word] = (map[word] ?? 0) + 1;
      return map;
    });
  }

  List<String> _tokenize(String content) {
    return content.toLowerCase().split(RegExp(r'\s+'));
  }

  void printTfIdfMatrix() {
    print('Term\t${documents.map((d) => d.id).join('\t')}');
    for (var i = 0; i < terms.length; i++) {
      var row = [terms[i]];
      for (var j = 0; j < documents.length; j++) {
        row.add(tfIdfMatrix[j][i].toStringAsFixed(3));
      }
      print(row.join('\t'));
    }
  }

  double calculateCosineSimilarity(String docId1, String docId2) {
    var vector1 = tfIdfMatrix[docToIndex[docId1]!];
    var vector2 = tfIdfMatrix[docToIndex[docId2]!];

    var dotProduct = 0.0;
    var magnitude1 = 0.0;
    var magnitude2 = 0.0;

    for (var i = 0; i < terms.length; i++) {
      dotProduct += vector1[i] * vector2[i];
      magnitude1 += vector1[i] * vector1[i];
      magnitude2 += vector2[i] * vector2[i];
    }

    magnitude1 = math.sqrt(magnitude1);
    magnitude2 = math.sqrt(magnitude2);

    if (magnitude1 == 0 || magnitude2 == 0) return 0;
    return dotProduct / (magnitude1 * magnitude2);
  }

  double calculateCosineDistance(String docId1, String docId2) {
    return 1 - calculateCosineSimilarity(docId1, docId2);
  }

  List<String> getTopTerms(String docId, int n) {
    var docIndex = docToIndex[docId]!;
    var termScores = List<MapEntry<String, double>>.generate(
      terms.length,
      (i) => MapEntry(terms[i], tfIdfMatrix[docIndex][i]),
    );
    termScores.sort((a, b) => b.value.compareTo(a.value));
    return termScores.take(n).map((e) => e.key).toList();
  }

  List<String> searchDocuments(String query, int topN) {
    var queryTerms = _tokenize(query);
    var docScores = List.generate(documents.length, (_) => 0.0);

    for (var term in queryTerms) {
      var termIndex = termToIndex[term];
      if (termIndex != null) {
        for (var i = 0; i < documents.length; i++) {
          docScores[i] += tfIdfMatrix[i][termIndex];
        }
      }
    }

    var docIndices = List.generate(documents.length, (i) => i);
    docIndices.sort((a, b) => docScores[b].compareTo(docScores[a]));
    return docIndices.take(topN).map((i) => documents[i].id).toList();
  }

  double getTfIdfScore(String term, String docId) {
    var termIndex = termToIndex[term];
    var docIndex = docToIndex[docId];
    if (termIndex == null || docIndex == null) return 0;
    return tfIdfMatrix[docIndex][termIndex];
  }

  String getHighestScoringDocument(String term) {
    var termIndex = termToIndex[term];
    if (termIndex == null) return '';
    var maxScore = 0.0;
    var maxDocIndex = 0;
    for (var i = 0; i < documents.length; i++) {
      if (tfIdfMatrix[i][termIndex] > maxScore) {
        maxScore = tfIdfMatrix[i][termIndex];
        maxDocIndex = i;
      }
    }
    return documents[maxDocIndex].id;
  }
}
