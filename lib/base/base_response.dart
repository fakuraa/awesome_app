import 'package:awesome_app/model/picture.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'status')
  int status;
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'domain')
  String domain;
  @JsonKey(name: 'photos')
  List<Picture>? data;
  @JsonKey(name: "page")
  int? page;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "total_results")
  int? totalResults;
  @JsonKey(name: "next_page")
  String? nextPage;
  @JsonKey(name: "prev_page")
  String? prevPage;

  BaseResponse({
    required this.status,
    required this.message,
    required this.domain,
    this.page,
    this.perPage,
    this.totalResults,
    this.nextPage,
    this.prevPage,
    this.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      status: json["status"],
      message: json["message"],
      domain: json["domain"],
      page: json["page"],
      perPage: json["per_page"],
      data: json["photos"] == null
          ? []
          : List<Picture>.from(json["photos"]!.map((x) => Picture.fromJson(x))),
      totalResults: json["total_results"],
      nextPage: json["next_page"],
      prevPage: json["prev_page"],
    );
  }

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "photos": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total_results": totalResults,
        "next_page": nextPage,
        "prev_page": prevPage,
      };
}
