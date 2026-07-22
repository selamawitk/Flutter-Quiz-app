import 'package:frontend/domain/resources/entities/resource.dart';
import '../resource_service.dart';

class ResourcesRemoteDataSource {
  final ResourceService _resourceService = ResourceService();

  Future<List<Resource>> getResources() async {
    final resourcesData = await _resourceService.getAllResources();
    return resourcesData.map((data) => Resource(
      id: data['_id'] ?? data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      url: data['url'] ?? '',
    )).toList();
  }

  Future<void> removeResource(String id) async {
    await _resourceService.deleteResource(id);
  }
}
