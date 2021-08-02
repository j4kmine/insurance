import 'package:boilerplate/models/document/document.dart';

class DocumentList {
  final List<Document>? documents;

  DocumentList({
    this.documents,
  });

  factory DocumentList.fromJson(List<dynamic> json) {
    List<Document> documents = <Document>[];
    documents = json.map((post) => Document.fromJson(post)).toList();

    return DocumentList(
      documents: documents,
    );
  }
}
