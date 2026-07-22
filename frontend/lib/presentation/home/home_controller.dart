import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/home/usecases/start_app.dart';

final homeControllerProvider = StateNotifierProvider<HomeController, bool>((ref) {
  final useCase = StartApp(); // inject via constructor if needed
  return HomeController(useCase);
});

class HomeController extends StateNotifier<bool> {
  final StartApp _startApp;

  HomeController(this._startApp) : super(false);

  void startApp() {
    _startApp();
    state = true;
  }
}
