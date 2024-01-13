import 'package:get_storage/get_storage.dart';

class StorageUtil {
  static final _box = GetStorage();

  // Save a key-value pair to storage
  static void saveValue(String key, dynamic value) {
    _box.write(key, value);
  }

  // Get the value associated with a key from storage
  static dynamic getValue(String key) async{
    var val= await _box.read(key);
    return val;
  }

  // Remove a key-value pair from storage
  static void removeValue(String key) {
    _box.remove(key);
  }

  // Clear all stored data
  static void clearAll() {
    _box.erase();
  }
}
