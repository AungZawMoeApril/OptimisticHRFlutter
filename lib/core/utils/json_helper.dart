/// Helper class for working with JSON data
class JsonHelper {
  /// Gets a field from a JSON object by path, with support for nested objects
  static dynamic getJsonField(dynamic json, String path, [bool array = false]) {
    if (json == null) return null;
    
    final pathElements = path.split('.');
    dynamic result = json;
    for (String pathElement in pathElements) {
      if (result == null) return null;
      
      if (pathElement.startsWith(r'$')) {
        pathElement = pathElement.substring(1);
      }
      
      if (result is Map) {
        result = result[pathElement];
      } else if (result is List) {
        try {
          final index = int.parse(pathElement);
          result = result[index];
        } catch (e) {
          return null;
        }
      } else {
        return null;
      }
    }
    
    if (array && result is List) {
      return result.map((e) => e?.toString()).toList();
    }
    
    return result;
  }
}