import 'package:flutter/material.dart';
import '../../domain/result/entities/result.dart';
import '../../application/result/usecases/fetch_results.dart';

class ResultController extends ChangeNotifier {
  final FetchResultUseCase fetchResultUseCase;

  Result? _result;
  Result? get result => _result;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  ResultController({required this.fetchResultUseCase});

  Future<void> loadResult() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _result = await fetchResultUseCase();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
