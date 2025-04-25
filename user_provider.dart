import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:matrimonyapp/user_model.dart';
import 'api_screen.dart';
import 'database_helper.dart';

class UserProvider with ChangeNotifier {
  List<UserModel> _users = [];
  List<UserModel> _favoriteUsers = [];
  final ApiService _apiService = ApiService();
  bool _isConnected = false;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  List<UserModel> get users => _users;
  List<UserModel> get favoriteUsers => _favoriteUsers;
  bool get isConnected => _isConnected;

  UserProvider() {
    _initConnectivity();
    loadUsers();
  }

  Future<void> _initConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _isConnected = !connectivityResult.contains(ConnectivityResult.none);
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _isConnected = !results.contains(ConnectivityResult.none);
      notifyListeners();
    });
    notifyListeners();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> loadUsers() async {
    if (_isConnected) {
      try {
        _users = await _apiService.fetchUsers();
      } catch (e) {
        _users = (await DatabaseHelper.instance.getAllUsers()).map((userMap) => UserModel.fromMap(userMap)).toList();
      }
    } else {
      _users = (await DatabaseHelper.instance.getAllUsers()).map((userMap) => UserModel.fromMap(userMap)).toList();
    }
    notifyListeners();
  }

  Future<List<UserModel>> getAllUsers() async {
    if (_isConnected) {
      try {
        return await _apiService.fetchUsers();
      } catch (e) {
        return (await DatabaseHelper.instance.getAllUsers()).map((userMap) => UserModel.fromMap(userMap)).toList();
      }
    } else {
      return (await DatabaseHelper.instance.getAllUsers()).map((userMap) => UserModel.fromMap(userMap)).toList();
    }
  }

  Future<void> addUser(UserModel user) async {
    if (_isConnected) {
      try {
        final addedUser = await _apiService.addUser(user);
        _users.add(addedUser);
      } catch (e) {
        int insertedId = await DatabaseHelper.instance.insertUser(user.toMap());
        if (insertedId != -1) {
          user.id = insertedId;
          _users.add(user);
        }
      }
    } else {
      int insertedId = await DatabaseHelper.instance.insertUser(user.toMap());
      if (insertedId != -1) {
        user.id = insertedId;
        _users.add(user);
      }
    }
    notifyListeners();
  }

  Future<void> editUser(String id, UserModel updatedUser) async {
    if (_isConnected) {
      try {
        await _apiService.updateUser(id, updatedUser);
        await loadUsers();
      } catch (e) {
        await DatabaseHelper.instance.updateUser(int.parse(id), updatedUser.toMap());
        await loadUsers();
      }
    } else {
      await DatabaseHelper.instance.updateUser(int.parse(id), updatedUser.toMap());
      await loadUsers();
    }
  }

  Future<void> deleteUser(String id) async {
    if (_isConnected) {
      try {
        await _apiService.deleteUser(id);
        await loadUsers();
      } catch (e) {
        await DatabaseHelper.instance.deleteUser(int.parse(id));
        await loadUsers();
      }
    } else {
      await DatabaseHelper.instance.deleteUser(int.parse(id));
      await loadUsers();
    }
  }

  Future<void> toggleFavorite(int userId) async {
    final user = _users.firstWhere((u) => u.id == userId);
    final newFavoriteStatus = !user.isFavorite;
    if (_isConnected) {
      try {
        await _apiService.toggleFavorite(userId.toString(), user.isFavorite);
        user.isFavorite = newFavoriteStatus;
        await loadFavoriteUsers();
      } catch (e) {
        await DatabaseHelper.instance.toggleFavorite(userId);
        user.isFavorite = newFavoriteStatus;
        await loadFavoriteUsers();
      }
    } else {
      await DatabaseHelper.instance.toggleFavorite(userId);
      user.isFavorite = newFavoriteStatus;
      await loadFavoriteUsers();
    }
    notifyListeners();
  }

  Future<void> loadFavoriteUsers() async {
    if (_isConnected) {
      try {
        _favoriteUsers = (await _apiService.fetchUsers()).where((user) => user.isFavorite).toList();
      } catch (e) {
        _favoriteUsers = (await DatabaseHelper.instance.getFavoriteUsers()).map((userMap) => UserModel.fromMap(userMap)).toList();
      }
    } else {
      _favoriteUsers = (await DatabaseHelper.instance.getFavoriteUsers()).map((userMap) => UserModel.fromMap(userMap)).toList();
    }
    notifyListeners();
  }

  void setFavoriteUsers(List<UserModel> users) {
    _favoriteUsers = users;
    notifyListeners();
  }
}