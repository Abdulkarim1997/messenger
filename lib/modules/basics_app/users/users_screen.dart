import 'package:flutter/material.dart';

import '../../../models/user/user_model.dart';




class UsersScreen extends StatelessWidget {

    List<UserModle> users = [
    UserModle(id: 1, named: 'Abdulkarim', phone: '+963941549480'),
    UserModle(id: 2, named: 'Ahmad', phone: '+963942020480'),
    UserModle(id: 3, named: 'Omar', phone: '+963920009480'),
    UserModle(id: 4, named: 'fatima', phone: '+963941549480'),
    UserModle(id: 5, named: 'Sami', phone: '+963941549480'),
    UserModle(id: 6, named: 'mahmod', phone: '+963941549480'),
    UserModle(id: 1, named: 'Abdulkarim', phone: '+963941549480'),
    UserModle(id: 2, named: 'Ahmad', phone: '+963941549480'),
    UserModle(id: 3, named: 'Omar', phone: '+963941549480'),
    UserModle(id: 4, named: 'fatima', phone: '+963941549480'),
    UserModle(id: 5, named: 'Sami', phone: '+963970009480'),
    UserModle(id: 6, named: 'mahmod', phone: '+963970009480'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding:  EdgeInsetsDirectional.only(start: 20),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
      ),
    );
  }
}

Widget buildUserItem( UserModle user) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
           CircleAvatar(
            radius: 27.0,
            child: Text(
              '${user.id}',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
           SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children:  [
              Text
                (
                '${user.named}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${user.phone}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
