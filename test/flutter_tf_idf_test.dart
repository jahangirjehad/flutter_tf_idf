import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_tf_idf/flutter_tf_idf.dart';

void main() {
  group('TF-IDF Tests', () {
    late TfIdf tfIdf;

    setUp(() {
      tfIdf = TfIdf([
        Document('1', 'The art of baking delicious cakes'),
        Document('2', 'Painting techniques for beginners'),
        Document('3', 'Culinary arts: baking and beyond'),
      ]);
    });

    test('getTopTerms returns correct number of terms', () {
      expect(tfIdf.getTopTerms('1', 3).length, equals(3));
    });

    test('getTfIdfScore returns non-zero score for existing term', () {
      expect(tfIdf.getTfIdfScore('baking', '1'), isNot(equals(0)));
    });

    test('getTfIdfScore returns zero for non-existing term', () {
      expect(tfIdf.getTfIdfScore('nonexistent', '1'), equals(0));
    });

    test('searchDocuments returns correct number of results', () {
      expect(tfIdf.searchDocuments('art', 2).length, equals(2));
    });

    test('calculateCosineSimilarity returns value between 0 and 1', () {
      var similarity = tfIdf.calculateCosineSimilarity('1', '3');
      expect(similarity, greaterThanOrEqualTo(0));
      expect(similarity, lessThanOrEqualTo(1));
    });
  });
}
