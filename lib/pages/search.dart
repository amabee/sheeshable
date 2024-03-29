import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sheeshable/functions/searchUser_controller.dart';
import 'package:sheeshable/pages/profile_page.dart';
import 'package:sheeshable/utils/explore_grid.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = '';
  List<dynamic> searchedPeople = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceMaterialTransparency: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: Colors.grey[200],
                height: 40,
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Icon(Icons.search, color: Colors.black),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 40,
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                              // Call getSearchedPerson and store the result
                              getSearchedPerson(value).then((result) {
                                setState(() {
                                  searchedPeople = result;
                                });
                              });
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Search...",
                            hintStyle: TextStyle(color: Colors.grey[600]),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (searchText.isEmpty)
            const ExploreGrid()
          else if (searchedPeople.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final Map<String, dynamic> personData = searchedPeople[index];
                  final String username = personData['username'] ?? 'Username';
                  final String fullName = personData['fullname'] ?? 'Full Name';
                  final String image = personData['image'] ?? 'Image';
                  return Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    color: Colors.white,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage("${url.imageUrl}/$image"),
                        foregroundImage: NetworkImage("${url.imageUrl}/$image"),
                      ),
                      title: Text(
                        username,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        fullName,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileBaseScreen(
                                      username: username,
                                      imageLink: image,
                                    )));
                      },
                    ),
                  );
                },
                childCount: searchedPeople.length,
              ),
            ),
        ],
      ),
    );
  }
}
