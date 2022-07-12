

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'StorageItem.dart';

class SecureStorage {
  final _secureStorage = const FlutterSecureStorage();
  final _accountNameController ="flutter_secure_storage_service";

  String? _getAccountName() =>
      _accountNameController.isEmpty ? null : _accountNameController;
  IOSOptions _getIOSOptions() => IOSOptions(
    accountName: _getAccountName(),
  );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  Future<void> writeSecureData(StorageItem newItem) async {
    await _secureStorage.write(
        key: newItem.key, value: newItem.value, aOptions: _getAndroidOptions(),iOptions:  _getIOSOptions());
  }
  Future<String?> readSecureData(String key) async {
    var readData =
    await _secureStorage.read(key: key, aOptions: _getAndroidOptions(),iOptions:  _getIOSOptions());
    return readData;
  }
  Future<void> deleteSecureData(StorageItem item) async {
    await _secureStorage.delete(key: item.key, aOptions: _getAndroidOptions(),iOptions:  _getIOSOptions());
  }
  Future<bool> containsKeyInSecureData(String key) async {
    var containsKey = await _secureStorage.containsKey(key: key, aOptions: _getAndroidOptions(),iOptions: _getIOSOptions());
    return containsKey;
  }

  Future<List<StorageItem>> readAllSecureData() async {
    var allData = await _secureStorage.readAll(aOptions: _getAndroidOptions(),iOptions:  _getIOSOptions());
    List<StorageItem> list =
    allData.entries.map((e) => StorageItem(e.key, e.value)).toList();
    return list;
  }
  Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions(),iOptions: _getIOSOptions());
  }

}