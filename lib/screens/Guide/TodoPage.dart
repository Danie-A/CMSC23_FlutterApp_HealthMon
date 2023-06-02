// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/Todo.dart';
// import '../providers/TodoListProvider.dart';
// import '../providers/AuthProvider.dart';
// import 'TodoModal.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'SigninPage.dart';
// import 'UserDetailsPage.dart';
// import 'AdminViewStudents.dart';

// class TodoPage extends StatefulWidget {
//   const TodoPage({super.key});

//   @override
//   State<TodoPage> createState() => _TodoPageState();
// }

// class _TodoPageState extends State<TodoPage> {
//   @override
//   Widget build(BuildContext context) {
//     // access the list of todos in the provider
//     Stream<QuerySnapshot> todosStream = context.watch<TodoListProvider>().todos;
//     Stream<User?> userStream = context.watch<AuthProvider>().uStream;

//     return StreamBuilder(
//         stream: userStream,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text("Error encountered! ${snapshot.error}"),
//             );
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (!snapshot.hasData) {
//             return const SigninPage();
//           }
//           // if user is logged in, display the scaffold containing the streambuilder for the todos
//           return displayScaffold(context, todosStream);
//         });
//   }

//   Scaffold displayScaffold(
//       BuildContext context, Stream<QuerySnapshot<Object?>> todosStream) {
//     return Scaffold(
//       drawer: Drawer(
//           child: ListView(padding: EdgeInsets.zero, children: [
//         ListTile(
//           title: const Text('Details'),
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const UserDetailsPage()));
//           },
//         ),
//         ListTile(
//           title: const Text('Logout'),
//           onTap: () {
//             context.read<AuthProvider>().signOut();
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//           title: const Text('View Students'),
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const AdminViewStudents()));
//           },
//         ),
//       ])),
//       appBar: AppBar(
//         backgroundColor: Color.fromARGB(255, 10, 41, 24),
//         title: Row(children: const [
//           Icon(Icons.edit_square, color: Colors.green),
//           SizedBox(width: 14),
//           Text(
//             "To Do List",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           )
//         ]),
//       ),
//       body: Container(
//           padding: const EdgeInsets.only(top: 16),
//           child: StreamBuilder(
//             stream: todosStream,
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text("Error encountered! ${snapshot.error}"),
//                 );
//               } else if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (!snapshot.hasData) {
//                 return const Center(
//                   child: Text("No Todos Found"),
//                 );
//               }

//               return ListView.builder(
//                 itemCount: snapshot.data?.docs.length,
//                 itemBuilder: ((context, index) {
//                   Todo todo = Todo.fromJson(snapshot.data?.docs[index].data()
//                       as Map<String, dynamic>);
//                   todo.id = snapshot.data?.docs[index].id;
//                   return Dismissible(
//                     key: Key(todo.id.toString()),
//                     onDismissed: (direction) {
//                       context.read<TodoListProvider>().deleteTodo(todo.id!);

//                       ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('${todo.title} dismissed')));
//                     },
//                     background: Container(
//                       color: Colors.red,
//                       child: const Icon(Icons.delete),
//                     ),
//                     child: ListTile(
//                       title: Text(todo.title),
//                       leading: Checkbox(
//                         value: todo.completed,
//                         onChanged: (bool? value) {
//                           context
//                               .read<TodoListProvider>()
//                               .toggleStatus(todo.id!, value!);
//                         },
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) => TodoModal(
//                                   type: 'Edit',
//                                   item: todo,
//                                 ),
//                               );
//                             },
//                             icon: const Icon(Icons.create_outlined),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) =>
//                                     TodoModal(type: 'Delete', item: todo),
//                               );
//                             },
//                             icon: const Icon(Icons.delete_outlined),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//               );
//             },
//           )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) => TodoModal(
//               type: 'Add',
//             ),
//           );
//         },
//         child: const Icon(Icons.add_outlined),
//       ),
//     );
//   }
// }
