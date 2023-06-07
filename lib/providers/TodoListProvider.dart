/*
  Created by: Claizel Coubeili Cepe
  Date: updated April 26, 2023
  Description: Sample todo app with Firebase 

  // USED AS A GUIDE ONLY
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Todo.dart';
import '../api/FirebaseTodoAPI.dart';

class TodoListProvider with ChangeNotifier {
  late FirebaseTodoAPI firebaseService;
  late Stream<QuerySnapshot> _todoStream;

  TodoListProvider() {
    firebaseService = FirebaseTodoAPI();
    fetchTodos();
  }

  // getter
  Stream<QuerySnapshot> get todos => _todoStream;

  fetchTodos() {
    _todoStream = firebaseService.getAllTodos();
    notifyListeners();
  }

  void addTodo(Todo item) async {
    String message = await firebaseService.addTodo(item.toJson(item));
    print(message);

    notifyListeners();
  }

  void editTodo(String id, String newTitle) async {
    String message = await firebaseService.editTodo(id, newTitle);
    print(message);
    notifyListeners();
  }

  void deleteTodo(String id) async {
    String message = await firebaseService.deleteTodo(id);
    print(message);
    notifyListeners();
  }

  void toggleStatus(String id, bool status) async {
    String message = await firebaseService.toggleStatus(id, status);
    notifyListeners();
  }
}
