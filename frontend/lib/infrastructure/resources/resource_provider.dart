import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'resource_service.dart';

// Provider for ResourceService
final resourceServiceProvider = Provider<ResourceService>((ref) {
  return ResourceService();
});

// Provider for resource list
final resourcesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final resourceService = ref.read(resourceServiceProvider);
  return await resourceService.getAllResources();
});

// Provider for resource categories
final resourceCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final resourceService = ref.read(resourceServiceProvider);
  return await resourceService.getResourceCategories();
});

// Provider for a specific resource by ID
final resourceByIdProvider = FutureProviderFamily<Map<String, dynamic>, String>((ref, id) async {
  final resourceService = ref.read(resourceServiceProvider);
  return await resourceService.getResourceById(id);
});

// Provider to handle resource operations
final resourceControllerProvider = Provider((ref) => ResourceController(ref));

class ResourceController {
  final Ref _ref;

  ResourceController(this._ref);

  // Create new resource
  Future<Map<String, dynamic>?> createResource(Map<String, dynamic> resourceData) async {
    try {
      final resourceService = _ref.read(resourceServiceProvider);
      final result = await resourceService.createResource(resourceData);
      
      // Refresh resource list
      _ref.refresh(resourcesProvider);
      
      return result;
    } catch (e) {
      return null;
    }
  }

  // Update resource
  Future<Map<String, dynamic>?> updateResource(String id, Map<String, dynamic> resourceData) async {
    try {
      final resourceService = _ref.read(resourceServiceProvider);
      final result = await resourceService.updateResource(id, resourceData);
      
      // Refresh resource list and specific resource
      _ref.refresh(resourcesProvider);
      _ref.refresh(resourceByIdProvider(id));
      
      return result;
    } catch (e) {
      return null;
    }
  }

  // Delete resource
  Future<bool> deleteResource(String id) async {
    try {
      final resourceService = _ref.read(resourceServiceProvider);
      final result = await resourceService.deleteResource(id);
      
      // Refresh resource list
      _ref.refresh(resourcesProvider);
      
      return result;
    } catch (e) {
      return false;
    }
  }
} 