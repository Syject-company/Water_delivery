import 'package:equatable/equatable.dart';

class BannerFields {
  static const String id = 'id';
  static const String image = 'photo';
  static const String url = 'linq';
}

class Banner extends Equatable {
  const Banner({
    required this.id,
    required this.image,
    required this.url,
  });

  final String id;
  final String image;
  final String url;

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json[BannerFields.id],
      image: json[BannerFields.image],
      url: json[BannerFields.url],
    );
  }

  @override
  List<Object> get props => [
        id,
        image,
        url,
      ];
}
