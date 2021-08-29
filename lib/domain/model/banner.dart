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

  Banner.fromJson(Map<String, dynamic> json)
      : this(
          id: json[BannerFields.id] as String,
          image: json[BannerFields.image] as String,
          url: json[BannerFields.url] as String,
        );

  Map<String, dynamic> toJson() => {
        BannerFields.id: id,
        BannerFields.image: image,
        BannerFields.url: url,
      };

  @override
  List<Object> get props => [
        id,
        image,
        url,
      ];
}
