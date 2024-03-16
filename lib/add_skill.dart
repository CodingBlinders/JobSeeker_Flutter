import 'package:flutter/material.dart';




class AddSkillScreen extends StatefulWidget {
  @override
  _AddSkillScreenState createState() => _AddSkillScreenState();
}

class _AddSkillScreenState extends State<AddSkillScreen> {
  TextEditingController _searchController = TextEditingController();
  List<String> _skillList = ['Flutter', 'Dart', 'React', 'Python']; // Sample skill list
  List<String> _selectedSkills = [];

  List<String> _filteredSkills = [];

  @override
  void initState() {
    super.initState();
    _filteredSkills = _skillList;
  }
  void _addSkill(String skill) {
    setState(() {
      _selectedSkills.add(skill);
      _searchController.clear();
      _filteredSkills = _skillList; // Reset filtered skills
    });
  }
  void _filterSkills(String query) {
    setState(() {
      _filteredSkills = _skillList.where((skill) => skill.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }



  void _removeSkill(String skill) {
    setState(() {
      _selectedSkills.remove(skill);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Skill'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search skill...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              ),
              onChanged: _filterSkills,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredSkills.length,
              itemBuilder: (context, index) {
                final skill = _filteredSkills[index];
                final isSelected = _selectedSkills.contains(skill);
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // spreadRadius: 2,
                        // blurRadius: 4,
                        // offset: Offset(0, 2),
                      ),
                    ]
                        : null,
                  ),
                  child: ListTile(
                    title: Text(skill),
                    trailing: isSelected
                        ? IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => _removeSkill(skill),
                    )
                        : null,
                    onTap: () {
                      if (!isSelected) {
                        _addSkill(skill);
                      } else {
                        _removeSkill(skill);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _selectedSkills
                  .map((skill) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        // spreadRadius: 2,
                        // blurRadius: 4,
                        // offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(skill),
                      SizedBox(width: 8.0),
                      GestureDetector(
                        onTap: () => _removeSkill(skill),
                        child: Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
