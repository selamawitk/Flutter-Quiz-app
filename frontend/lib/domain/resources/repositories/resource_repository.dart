import '../entities/resource.dart';

abstract class ResourceRepository {
  Future<List<Resource>> getResources();
  Future<void> removeResource(String id);
  Future<void> editResource(String id); // Optional for future use
}
