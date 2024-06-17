import 'package:flutter/material.dart';

class MoreItemsPage extends StatefulWidget {
  final List<String> items;

  const MoreItemsPage({super.key, required this.items});

  @override
  _MoreItemsPageState createState() => _MoreItemsPageState();
}

class _MoreItemsPageState extends State<MoreItemsPage> {
  late List<String> displayedItems;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    displayedItems = widget.items;
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      displayedItems = widget.items
          .where((item) => item.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Items in GridView'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(
                color: Colors.black
              ),
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32)
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: displayedItems.length,
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      displayedItems[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
