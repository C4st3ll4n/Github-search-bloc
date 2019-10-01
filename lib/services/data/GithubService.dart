import 'package:dio/dio.dart';
import 'package:github_search/models/SearchResult.dart';

class GithubService{
  final Dio dio = new Dio();

  Future<SearchResult> search(termo) async{
    try {
      Response response = await dio.get(
          "https://api.github.com/search/repositories?q=$termo");
      return SearchResult.fromJson(response.data);
    }catch(e){
      throw Exception(e);
    }
  }
}