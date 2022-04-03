import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List names = ["Ankit", "Arun", "Shanaya", "Aakriti"];
    List points = [50, 35, 20, 10];
    List url = [
      "https://images.vexels.com/media/users/3/145908/raw/52eabf633ca6414e60a7677b0b917d92-male-avatar-maker.jpg",
      "https://firebasestorage.googleapis.com/v0/b/aama-samaj-temp.appspot.com/o/b1.png?alt=media&token=47313275-0004-4f5a-af11-0f877da8ff2b",
      "https://firebasestorage.googleapis.com/v0/b/aama-samaj-temp.appspot.com/o/g1.png?alt=media&token=ae50c46e-da75-4b26-a94b-1230987f84c3",
      "https://st2.depositphotos.com/2703645/5669/v/950/depositphotos_56695433-stock-illustration-female-avatar.jpg"
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: RichText(
            text: TextSpan(
                text: "Leader Board",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
          backgroundColor: Colors.purple,
          iconTheme: IconThemeData(color: Color(0xFF071E22)),
          centerTitle: true,
          elevation: 0.0,
          toolbarHeight: 50,
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 300.0,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 300.0,
                    color: Colors.purple,
                  ),
                  Align(
                      alignment: Alignment(-0.7, 0),
                      child: StackItem(
                        id: 2,
                        name: names[1],
                        url: url[1],
                      )),
                  Align(
                    alignment: Alignment(0, -0.4),
                    child: StackItem(
                      id: 1,
                      name: names[0],
                      url: url[0],
                    ),
                  ),
                  Align(
                      alignment: Alignment(0.7, 0),
                      child: StackItem(
                        id: 3,
                        name: names[2],
                        url: url[2],
                      )),
                ],
              ),
            ),
            const TabBar(
              indicatorWeight: 4.0,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xffff6468),
              tabs: <Widget>[
                Tab(
                  text: "Running",
                ),
                Tab(text: "Overall"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  Container(
                    height: 100.0,
                    child: ListView.builder(
                      itemBuilder: (context, index) => ProfileItem(
                        index: index + 1,
                        name: names[index],
                        points: points[index],
                        url: url[index],
                      ),
                      shrinkWrap: true,
                      itemCount: 4,
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StackItem extends StatelessWidget {
  final bool large;
  final int id;
  final String url;
  final String name;

  const StackItem(
      {Key? key,
      this.large = false,
      required this.id,
      required this.url,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: large ? 90 : 60.0,
          height: large ? 90 : 60.0,
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image.network(
                      url,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.9, -0.9),
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(id.toString(),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
              ),
            ],
          ),
        ),
        Text(name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}

class ProfileItem extends StatelessWidget {
  final int index;
  final String url;
  final String name;
  final int points;
  const ProfileItem(
      {Key? key,
      required this.index,
      required this.url,
      required this.name,
      required this.points})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "$index",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CircleAvatar(
              radius: 70,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.network(
                    url,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    style: BorderStyle.solid,
                    width: 4.0,
                    color: Colors.green,
                  ),
                ),
                padding: EdgeInsets.all(4.0),
                child: Text(points.toString())),
          ),
        ],
      ),
    );
  }
}
