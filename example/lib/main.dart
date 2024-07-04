import 'package:flutter/material.dart';
import 'package:flutter_tf_idf/flutter_tf_idf.dart';

void main() {
  runApp(TfIdfDemoApp());
}

class TfIdfDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TF-IDF Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TfIdfDemo(),
    );
  }
}

class TfIdfDemo extends StatelessWidget {
  final TfIdf tfIdf;

  TfIdfDemo()
      : tfIdf = TfIdf([
          Document('1', 'The art of baking delicious cakes'),
          Document('2', 'Painting techniques for beginners'),
          Document('3', 'Culinary arts: baking and beyond'),
        ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TF-IDF Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Documents:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              ...tfIdf.documents
                  .map((doc) => Text('Document ${doc.id}: ${doc.content}')),
              SizedBox(height: 20),
              Text(
                'Top terms in document 1:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(tfIdf.getTopTerms('1', 3).join(', ')),
              SizedBox(height: 20),
              Text(
                'Search results for "art":',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(tfIdf.searchDocuments('art', 2).join(', ')),
              SizedBox(height: 20),
              Text(
                'Cosine similarity between document 1 and document 2:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                  tfIdf.calculateCosineSimilarity('1', '2').toStringAsFixed(3)),
              SizedBox(height: 20),
              Text(
                'Cosine distance between document 1 and document 2:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(tfIdf.calculateCosineDistance('1', '2').toStringAsFixed(3)),
              SizedBox(height: 20),
              Text(
                'TF-IDF score of "art" in document 1:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(tfIdf.getTfIdfScore('art', '1').toStringAsFixed(3)),
              SizedBox(height: 20),
              Text(
                'Highest scoring document for the term "art":',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(tfIdf.getHighestScoringDocument('art')),
              SizedBox(height: 20),
              Text(
                'TF-IDF Matrix:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              for (var term in tfIdf.terms)
                Text(
                    '$term: ${tfIdf.documents.map((doc) => tfIdf.getTfIdfScore(term, doc.id).toStringAsFixed(3)).join(', ')}'),
            ],
          ),
        ),
      ),
    );
  }
}
