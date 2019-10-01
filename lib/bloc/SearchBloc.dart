import 'package:github_search/models/SearchResult.dart';
import 'package:github_search/services/data/GithubService.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  GithubService _service = new GithubService();

  final _searchControler = new BehaviorSubject<String>();

  Observable<String> get searchFlux => _searchControler.stream;

  Sink<String> get searchEvent => _searchControler.sink;

  Observable<SearchResult> apiResultFlux;

  SearchBloc() {
    apiResultFlux = searchFlux
        .distinct()
        .where((valor) => valor.length > 2)
    .debounceTime(Duration(milliseconds: 500))
        .asyncMap(_service.search)
        .switchMap((valor) => Observable.just(valor));
  }

  void dispose() {
    _searchControler?.close();
  }
}
