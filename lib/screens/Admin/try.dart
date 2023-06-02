
//   int? numUsersNull = snapshot.data?.docs.length;
//   int numUsers=0;
//   if(numUsersNull!=null){
//     numUsers = numUsersNull;
//  for (int i = 0; i < numUsers; i++) {

//       UserDetail userDetail = UserDetail.studentFromJson(
//         snapshot.data?.docs[i].data() as Map<String, dynamic>,
//       );
//       // Add userDetail to the list
//       userDetailsList.add(userDetail);

      
//   }

//   }


// import 'package:intl/intl.dart';

// // Assuming you have a list of date strings in the format "June 6, 2023"
// List<String> dates = [
//   'June 2, 2023',
//   'June 5, 2023',
//   'June 1, 2023',
//   'June 3, 2023',
// ];

// // Create a formatter for the desired date format
// DateFormat dateFormat = DateFormat('MMMM d, yyyy');

// // Parse the date strings into DateTime objects
// List<DateTime> parsedDates = dates.map((date) => dateFormat.parse(date)).toList();

// // Sort the DateTime objects
// parsedDates.sort((a, b) => a.compareTo(b));

// // Convert the sorted DateTime objects back to the desired format
// List<String> sortedDates = parsedDates.map((date) => dateFormat.format(date)).toList();

// // Output the sorted dates
// sortedDates.forEach(print);




// Widget _showSorted(BuildContext context, String filterValue) {
//     Stream<QuerySnapshot> sortedStream;
//     if (filterValue == 'StudentNumber') {
//       sortedStream =
//           context.watch<UserDetailListProvider>().sortStudentNoStream;
//     } else {
//       sortedStream =
//           context.watch<UserDetailListProvider>().sortDateStream;
//     }