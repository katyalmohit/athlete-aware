import 'package:athlete_aware/screens/forums/forum_screen.dart';
import 'package:flutter/material.dart';

class ForumGroups extends StatefulWidget {
  @override
  _ForumGroupsState createState() => _ForumGroupsState();
}

class _ForumGroupsState extends State<ForumGroups> {
  String selectedTab = 'All'; // Selected tab for filtering
  String searchText = ''; // Search text entered by the user

  final List<Map<String, String>> allCommunities = [
    {'name': 'Drug Testing Awareness', 'members': '3k', 'category': 'WADA Policies'},
    {'name': 'WADA Guidelines', 'members': '4k', 'category': 'Banned Substances'},
    {'name': 'Ethical Sports', 'members': '2k', 'category': 'Fair Play'},
    {'name': 'Sports Integrity', 'members': '8k', 'category': 'Clean Sports'},
    {'name': 'Anti-Doping 101', 'members': '10k', 'category': 'Testing Procedures'},
    {'name': 'Clean Sports Initiative', 'members': '5k', 'category': 'Sports Integrity'},
    {'name': 'Doping-Free Athletes', 'members': '7k', 'category': 'Athlete Rights'},
    {'name': 'Fair Play', 'members': '15k', 'category': 'Ethical Sports'},
  ];

  @override
  Widget build(BuildContext context) {
    // Filtered list based on selected tab and search text
    final filteredCommunities = allCommunities.where((community) {
      final matchesCategory = selectedTab == 'All' || community['category'] == selectedTab;
      final matchesSearch = community['name']!.toLowerCase().contains(searchText.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Communities'),
        backgroundColor: const Color.fromARGB(179, 0, 159, 244),
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(height:15),
            _buildSearchBar(),
            const SizedBox(height: 10),
            _buildTabs(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildCommunityList(filteredCommunities),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search communities...',
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
      ),
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
    );
  }

  Widget _buildTabs() {
    final categories = ['All', 'WADA Policies', 'Banned Substances', 'Fair Play', 'Clean Sports'];

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: categories.map((category) {
        final isSelected = category == selectedTab;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedTab = category;
            });
          },
          child: Chip(
            backgroundColor: isSelected ? Colors.blue : Colors.grey[800],
            label: Text(
              category,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCommunityList(List<Map<String, String>> communities) {
    return Column(
      children: communities.map((community) {
        return ListTile(
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/icon.jpg'),
            backgroundColor: Colors.grey,
          ),
          title: Text(
            community['name']!,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '${community['members']} members',
            style: const TextStyle(color: Colors.grey),
          ),
          trailing: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForumScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.grey[800],
              backgroundColor: Colors.white,
            ),
            child: const Text('Join'),
          ),
        );
      }).toList(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: const Center(
        child: Text('Welcome to the community!'),
      ),
    );
  }
}