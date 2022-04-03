import 'package:aama_samaj_temp_frontend/controllers/post_controller.dart';
import 'package:aama_samaj_temp_frontend/models/post_model.dart';
import 'package:aama_samaj_temp_frontend/views/add_post.dart';
import 'package:aama_samaj_temp_frontend/views/info_page.dart';
import 'package:aama_samaj_temp_frontend/widgets/doubt_interact.dart';

import '../services/storage/storage.dart';
import '../views/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Profile profile = Get.put(const Profile());
    DoubtInteract doubtInteract = Get.put(DoubtInteract());
    PostController postController = Get.put(PostController());
    var options = [
      {
        "text": "Edit",
        "icon": const Icon(
          Icons.edit,
          color: Colors.orange,
        )
      },
      {
        "text": "Delete",
        "icon": const Icon(
          Icons.delete,
          color: Colors.red,
        ),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Get.to(() => profile);
            },
            child: const Icon(Icons.settings),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
        leading: GestureDetector(
            onTap: () {
              Get.to(() => InfoPage());
            },
            child: Icon(Icons.info)),
        title: RichText(
          text: const TextSpan(
              text: "Posts",
              style: TextStyle(
                  color: Color(0xFF071E22),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(color: Color(0xFF071E22)),
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: 50,
      ),
      body: Container(
        child: FutureBuilder<List<PostModel>>(
          future: postController.postData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                debugPrint("Got error. The error is: ");
                debugPrint(snapshot.error.toString());
                return const Center(
                  child: Text("Some Error occured while fetching posts"),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Column(
                          children: <Widget>[
                            const Divider(
                              color: Colors.grey,
                            ),
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20,
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: Image.network(
                                          snapshot.data![index].userImageUrl,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: Text(snapshot.data![index].userName,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  const Spacer(),
                                  Text(
                                    snapshot.data![index].progress,
                                    style: const TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  snapshot.data![index].userId ==
                                          box.read("userId")
                                      ? PopupMenuButton(
                                          itemBuilder: (context) {
                                            return List.generate(options.length,
                                                (index) {
                                              return PopupMenuItem(
                                                child: Text(options[index]
                                                        ["text"]
                                                    .toString()),
                                                value: index,
                                              );
                                            });
                                          },
                                          onSelected: (value) {
                                            if (value == 0) {
                                            } else {}
                                          },
                                        )
                                      : const SizedBox(
                                          width: 0,
                                          height: 0,
                                          child: null,
                                        ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: snapshot.data![index].imageUrl == ""
                                  ? Container(
                                      width: 0,
                                      height: 0,
                                      child: null,
                                    )
                                  : Image.network(
                                      snapshot.data![index].imageUrl,
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: const Text(
                                    "Issue",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 25),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: Colors.blue,
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.menu_book_outlined,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        snapshot.data![index].category,
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                snapshot.data![index].description,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            doubtInteract.getDoubtInteract(
                                snapshot.data![index].id,
                                snapshot.data![index].userId),
                          ],
                        ),
                      );
                    });
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              debugPrint("Got nothing to show");
              return Container();
            }
          },
        ),
      ),
    );
  }
}
