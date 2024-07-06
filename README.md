# flutter_tf_idf

A Dart package for calculating TF-IDF (Term Frequency-Inverse Document Frequency) and performing text analysis tasks in Flutter applications.

## Features

- Calculate TF-IDF matrix for a collection of documents
- Compute cosine similarity and distance between documents
- Retrieve top terms for a specific document
- Search documents based on a query
- Get TF-IDF scores for specific terms and documents
- Find the highest-scoring document for a given term

## Getting Started
Add `flutter_tf_idf` to your `pubspec.yaml`:
```yaml
dependencies:
  flutter_tf_idf: ^1.0.0
```
Then run:
```flutter pub get```
## Import:
```import 'package:flutter_tf_idf/flutter_tf_idf.dart';```

## Usage:

## Create a TfIdf instance with a list of documents:
```
  var documents = [
    Document('doc1', 'This is a sample document'),
    Document('doc2', 'Another example document'),
    Document('doc3', 'A third document for demonstration'),
  ];
  final tfIdf = TfIdf(documents);
```
## Calculate Cosine Similarity: 
```
    double similarity = tfIdf.calculateCosineSimilarity('doc1', 'doc2');
    print('Cosine similarity between doc1 and doc2: $similarity');
```
## Calculate Cosine Distance
```
    double distance = tfIdf.calculateCosineDistance('doc1', 'doc2');
    print('Cosine distance between doc1 and doc2: $distance');
```
## Get Top Terms for a Document
```
    List<String> topTerms = tfIdf.getTopTerms('doc1', 5);
    print('Top 5 terms in doc1: $topTerms');
```
## Search Documents
```
    List<String> searchResults = tfIdf.searchDocuments('first document', 2);
    print('Top 2 documents matching "first document": $searchResults');
```
## Get TF-IDF Score
```
    double score = tfIdf.getTfIdfScore('document', 'doc2');
    print('TF-IDF score of "document" in doc2: $score');
```
## Get Highest Scoring Document for a Term
```
    String docId = tfIdf.getHighestScoringDocument('third');
    print('Document with highest score for "third": $docId');
```
## Print TF-IDF Matrix
```
  tfIdf.printTfIdfMatrix();
```

## Additional information
For more information on how to use this package, please refer to the API documentation and the example provided in the [`example/main.dart`](./example/lib/main.dart) file.

## Author

This package is developed and maintained by [Jahangir Jehad](https://github.com/jahangirjehad).

## Show Your Support

If you find this package helpful, please consider giving it a star on GitHub. Your support helps to make this project more visible to others who might benefit from it.

[![Star on GitHub](https://img.shields.io/github/stars/jahangirjehad/flutter_tf_idf.svg?style=social)](https://github.com/jahangirjehad/flutter_tf_idf/stargazers)




