

import 'package:get_it/get_it.dart';
import 'package:image_capture/services/image_service.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerSingleton<ImageService>(ImageService());
}