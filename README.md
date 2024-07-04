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

Usage:
```
import 'package:flutter_tf_idf/flutter_tf_idf.dart';

void main() {
  var documents = [
    Document('doc1', 'This is a sample document'),
    Document('doc2', 'Another example document'),
    Document('doc3', 'A third document for demonstration'),
  ];

  var tfidf = TfIdf(documents);

  // Print TF-IDF matrix
  tfidf.printTfIdfMatrix();

  // Calculate cosine similarity between two documents
  var similarity = tfidf.calculateCosineSimilarity('doc1', 'doc2');
  print('Cosine similarity between doc1 and doc2: $similarity');

  // Get top terms for a document
  var topTerms = tfidf.getTopTerms('doc1', 3);
  print('Top 3 terms in doc1: $topTerms');

  // Search documents
  var searchResults = tfidf.searchDocuments('sample document', 2);
  print('Top 2 documents for query "sample document": $searchResults');
}
```

## Additional information

For more information on how to use this package, please refer to the API documentation and the example provided in the `example` folder.

If you encounter any issues or have feature requests, please file them in the [issue tracker](https://github.com/yourusername/flutter_tf_idf/issues).




