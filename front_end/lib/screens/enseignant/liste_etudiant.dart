import 'package:flutter/material.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  // Track expanded nodes
  final Set<String> _expandedNodes = {
    'Département Informatique',
    'LSI',
    '1ère année',
    'Amphi A',
    'A1',
    'A2',
    'Amphi B',
    'B1',
    
    'B2',
  };

  // Track checked items
  final Set<String> _checkedItems = {
    'B1',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD8C9A9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.list),
                          const SizedBox(width: 8),
                          Text(
                            'Liste des etudiants',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tree View
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFD6EAD8), // Light mint green
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    _buildTreeNode('Département Informatique', 0, true),
                    if (_expandedNodes.contains('Département Informatique'))
                      _buildTreeNode('LSI', 1, true),
                    if (_expandedNodes.contains('LSI')) ...[
                      _buildTreeNode('1ère année', 2, true),
                      if (_expandedNodes.contains('1ère année')) ...[
                        _buildTreeNode('Amphi A', 3, true),
                        if (_expandedNodes.contains('Amphi A')) ...[
                          _buildTreeNode('A1', 4, true),
                          if (_expandedNodes.contains('A1')) ...[
                            _buildTreeNode('A1TP1', 5, false),
                            _buildTreeNode('A1TP2', 5, false),
                          ],
                          _buildTreeNode('A2', 4, true),
                          if (_expandedNodes.contains('A2')) ...[
                            _buildTreeNode('A2TP1', 5, false),
                            _buildTreeNode('A2TP2', 5, false),
                          ],
                        ],
                        _buildTreeNode('Amphi B', 3, true),
                        if (_expandedNodes.contains('Amphi B')) ...[
                          _buildTreeNode('B1', 4, true),
                          if (_expandedNodes.contains('B1')) ...[
                            _buildTreeNode('B1TP1', 5, false),
                            _buildTreeNode('B1TP2', 5, false),
                          ],
                          _buildTreeNode('B2', 4, true),
                          if (_expandedNodes.contains('B2')) ...[
                            _buildTreeNode('B2TP1', 5, false),
                            _buildTreeNode('B2TP2', 5, false),
                          ],
                        ],
                      ],
                      _buildTreeNode('2ème année', 2, true),
                      _buildTreeNode('3ème année', 2, true),
                    ],
                  ],
                ),
              ),
            ),

            // Footer - Updated to match the screenshot more precisely
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 24, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Message button with text
                  Expanded(
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6EAD8),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          // Left circular green button with pencil icon
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Text
                          const Text(
                            'Envoyer un message',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Right circular green button with send icon
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreeNode(String title, int level, bool hasChildren) {
    return Padding(
      padding: EdgeInsets.only(left: level * 20.0, top: 4, bottom: 4),
      child: Row(
        children: [
          if (hasChildren)
            GestureDetector(
              onTap: () {
                setState(() {
                  if (_expandedNodes.contains(title)) {
                    _expandedNodes.remove(title);
                  } else {
                    _expandedNodes.add(title);
                  }
                });
              },
              child: Container(
                width: 20,
                alignment: Alignment.center,
                child: Text(
                  _expandedNodes.contains(title) ? 'V' : '>',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          else
            const SizedBox(width: 20),
          Expanded(
            child: Text(title),
          ),
          Checkbox(
            value: _checkedItems.contains(title),
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  _checkedItems.add(title);
                } else {
                  _checkedItems.remove(title);
                }
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
