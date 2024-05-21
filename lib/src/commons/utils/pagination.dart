final class Pagination<T> {
  final Metadata meta;
  final List<T> data;

  const Pagination({required this.meta, required this.data});

  factory Pagination.of(Map<String, dynamic> json, T Function(Map<String, dynamic>) builder) {
    return Pagination(
      meta: Metadata.fromJson(json['meta']),
      data: List.from(json['data']).map<T>((d) => builder(d)).toList(),
    );
  }
}

final class Metadata {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final int firstPage;
  final String firstPageUrl;
  final String lastPageUrl;
  final String? nextPageUrl;
  final String? prevPageUrl;

  const Metadata({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.firstPage,
    required this.firstPageUrl,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.prevPageUrl,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      total: json['total'],
      perPage: json['perPage'],
      currentPage: json['currentPage'],
      lastPage: json['lastPage'],
      firstPage: json['firstPage'],
      firstPageUrl: json['firstPageUrl'],
      lastPageUrl: json['lastPageUrl'],
      nextPageUrl: json['nextPageUrl'],
      prevPageUrl: json['prevPageUrl'],
    );
  }
}