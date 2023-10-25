class GlobalApiResponse {
  int? page;
  List<dynamic>? results;

  GlobalApiResponse({this.page, this.results});

  GlobalApiResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results = json['results'];
  }
}
