// import 'package:flutter/material.dart';

// class ForumGroups extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Communities'),
//         backgroundColor: Colors.black,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               // Add search functionality here
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         color: Colors.black,
//         padding: EdgeInsets.symmetric(horizontal: 8.0),
//         child: ListView(
//           children: [
//             SizedBox(height: 10),
//             _buildCategoriesRow(),
//             SizedBox(height: 20),
//             _buildSectionHeader('Recommended for you'),
//             _buildCommunityList([
//               {'name': 'r/C_Programming', 'members': '179k', 'posts': '96 weekly posts'},
//               {'name': 'r/photocritique', 'members': '1.7m', 'posts': '374 weekly posts'},
//               {'name': 'r/ElectronicsRepair', 'members': '30.6k', 'posts': '158 weekly posts'},
//               {'name': 'r/homeautomation', 'members': '4.3m', 'posts': '162 weekly posts'},
//             ]),
//             SizedBox(height: 20),
//             _buildSectionHeader('Similar to /esp32'),
//             _buildCommunityList([
//               {'name': 'r/WireGuard', 'members': '34.5k', 'posts': '59 weekly posts'},
//               {'name': 'r/esp8266', 'members': '65.2k', 'posts': '14 weekly posts'},
//               {'name': 'r/WLED', 'members': '41.8k', 'posts': '181 weekly posts'},
//               {'name': 'r/FastLED', 'members': '18.2k', 'posts': '66 weekly posts'},
//             ]),
//             SizedBox(height: 20),
//             _buildTrendingSection(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoriesRow() {
//     final categories = [
//       {'name': 'Internet Culture', 'icon': Icons.public},
//       {'name': 'Games', 'icon': Icons.games},
//       {'name': 'Q&As & Stories', 'icon': Icons.question_answer},
//       {'name': 'Technology', 'icon': Icons.computer},
//       {'name': 'Movies & TV', 'icon': Icons.movie},
//       {'name': 'Places & Travel', 'icon': Icons.map},
//       {'name': 'Business & Finance', 'icon': Icons.business},
//       {'name': 'Pop Culture', 'icon': Icons.stars},
//       {'name': 'Education & Career', 'icon': Icons.school},
//     ];

//     return Wrap(
//       spacing: 10.0,
//       runSpacing: 10.0,
//       children: categories.map((category) {
//         return Chip(
//           backgroundColor: Colors.grey[800],
//           label: Text(
//             category['name']!,
//             style: TextStyle(color: Colors.white),
//           ),
//           avatar: Icon(
//             category['icon'] as IconData?,
//             color: Colors.white,
//             size: 18.0,
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Text(
//       title,
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   Widget _buildCommunityList(List<Map<String, String>> communities) {
//     return Column(
//       children: communities.map((community) {
//         return ListTile(
//           leading: CircleAvatar(
//             backgroundImage: AssetImage('assets/image.png'),
//             backgroundColor: Colors.grey,
//           ),
//           title: Text(
//             community['name']!,
//             style: TextStyle(color: Colors.white),
//           ),
//           subtitle: Text(
//             '${community['members']} members • ${community['posts']}',
//             style: TextStyle(color: Colors.grey),
//           ),
//           trailing: ElevatedButton(
//             onPressed: () {
//               // Add join functionality here
//             },
//             style: ElevatedButton.styleFrom(
//               foregroundColor: Colors.grey[800],
//               backgroundColor: Colors.white,
//             ),
//             child: Text('Join'),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildTrendingSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader('Trending now in India'),
//         ListTile(
//           leading: CircleAvatar(
//             backgroundImage: AssetImage('assets/image.png'),
//             backgroundColor: Colors.grey,
//           ),
//           title: Text(
//             'r/TrendingCommunity',
//             style: TextStyle(color: Colors.white),
//           ),
//           subtitle: Text(
//             'Trending posts and topics',
//             style: TextStyle(color: Colors.grey),
//           ),
//         ),
//       ],
//     );
//   }
// }
