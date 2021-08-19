import 'package:equatable/equatable.dart';

class CategoryFields {
  static const String id = 'id';
  static const String imageUri = 'imageUri';
  static const String title = 'title';
}

class Category extends Equatable {
  const Category({
    required this.id,
    required this.imageUri,
    required this.title,
  });

  final String id;
  final String imageUri;
  final String title;

  Category.fromJson(Map<String, dynamic> json)
      : this(
          id: json[CategoryFields.id] as String,
          imageUri: json[CategoryFields.imageUri] as String,
          title: json[CategoryFields.title] as String,
        );

  Map<String, dynamic> toJson() => {
        CategoryFields.id: id,
        CategoryFields.imageUri: imageUri,
        CategoryFields.title: title,
      };

  @override
  List<Object> get props => [
        id,
        imageUri,
        title,
      ];
}
