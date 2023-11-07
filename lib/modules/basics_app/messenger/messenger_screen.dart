import 'package:flutter/material.dart';

class messenger_screen extends StatelessWidget {
  const messenger_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
         titleSpacing: 20.0,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 20.0,
               backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg'),
            ),
            SizedBox(
              width: 15.0,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                radius: 20.0,
                child: Icon(Icons.camera_alt, size: 18.0),
              )),
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                radius: 20.0,
                child: Icon(Icons.edit, size: 18.0),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey[300],
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.search,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      'Search',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Container(
                height:105.0,
                child: ListView.separated(

                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                    itemBuilder: (context,index) => buildStoryItem(),

                  separatorBuilder: (BuildContext context, int index) => const SizedBox(
                    width:20.0,
                  ),

                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap:true,
                  itemBuilder: (context,index) =>buildChatItem() ,
                  separatorBuilder: (context,index) => SizedBox(
                    height: 20.0,
                  ),
                  itemCount: 15
              )

            ],
          ),
        ),
      ),
    );
  }
}
// 1. build item
// 2. build List
// 3. add item to List

// arrow function
Widget buildChatItem() => Row(
  children: [
    Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: const [
        CircleAvatar(
          radius: 30.0,
          backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg'),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(bottom: 3.0, end: 3.0),
          child: CircleAvatar(
            radius: 7.0,
            backgroundColor: Colors.red,
          ),
        ),
      ],
    ),
    const SizedBox(
      width: 20.0,
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Abdulkarim Salem',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Hello my name is Abdulkarim',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: 7.0,
                  height: 7.0,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const Text(
                '02:00 pm',
              ),
            ],
          ),
        ],
      ),
    ),
  ],
);
Widget buildStoryItem() =>   Container(
  width: 60.0,
  child: Column(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: const [
          CircleAvatar(
            radius: 30.0,
             backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__480.jpg'),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
                bottom: 3.0, end: 3.0),
            child: CircleAvatar(
              radius: 7.0,
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 6.0,
      ),
      const Text(
        'Abdulkarim Salem',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  ),
);
