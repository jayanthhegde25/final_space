import 'package:get_it/get_it.dart';

import '../controllers/final_space_controller.dart';
import '../router/app_router.gr.dart';

var locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(AppRouter());
  locator.registerSingleton(FinalSpaceController());
}