import 'package:frontend/domain/resources/entities/resource.dart';

typedef GetResources = Future<List<Resource>> Function();
typedef RemoveResource = Future<void> Function(String id);
