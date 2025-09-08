class PaginationModel {
  final int totalCount;
  final int perPage;
  final int maxPage;
  final int currentPage;

  PaginationModel({
    required this.totalCount,
    required this.perPage,
    required this.maxPage,
    required this.currentPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      totalCount: json['totalCount'] ?? 0,
      perPage: json['perPage'] ?? 0,
      maxPage: json['maxPage'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'perPage': perPage,
      'maxPage': maxPage,
      'currentPage': currentPage,
    };
  }
}
