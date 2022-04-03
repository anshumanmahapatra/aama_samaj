import 'package:aama_samaj_temp_frontend/controllers/post_controller.dart';
import 'package:aama_samaj_temp_frontend/models/length_model.dart';
import 'package:aama_samaj_temp_frontend/models/vote_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoubtInteract {
  getDoubtInteract(int postId, int userId) {
    PostController postController = Get.put(PostController());
    postController.checkUpvoted(postId, userId);
    postController.checkDownvoted(postId, userId);
    postController.getCommentsLength(postId);
    postController.getDownvotesLength(postId);
    postController.getUpvotesLength(postId);
    return Row(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<VoteModel>(
            future: postController.checkHasUpvoted,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  debugPrint("Got error. The error is: ");
                  debugPrint(snapshot.error.toString());
                  return const Center(
                    child: Icon(Icons.arrow_upward_sharp, color: Colors.grey, size: 25),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_upward_sharp,
                      color: snapshot.data!.isVoted == true
                          ? Colors.green
                          : Colors.grey,
                      size: 25,
                    ),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: Icon(Icons.arrow_upward_sharp, color: Colors.grey, size: 25),
                  );
              } else {
                debugPrint("Got nothing to show");
                return Container();
              }
            },
          ),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder<LengthModel>(
            future: postController.upvotesLength,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  debugPrint("Got error. The error is: ");
                  debugPrint(snapshot.error.toString());
                  return const Center(
                    child: Text("0"),
                  );
                } else {
                  return Text(snapshot.data!.length.toString());
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text("0"),
                );
              } else {
                debugPrint("Got nothing to show");
                return Container();
              }
            },
          )
        ],
      ),
      const SizedBox(
        width: 5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<VoteModel>(
            future: postController.checkHasDownvoted,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  debugPrint("Got error. The error is: ");
                  debugPrint(snapshot.error.toString());
                  return const Center(
                    child: Icon(Icons.arrow_downward_sharp, color: Colors.grey, size: 25),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.arrow_downward_sharp,
                      color: snapshot.data!.isVoted == true
                          ? Colors.red
                          : Colors.grey,
                      size: 25,
                    ),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: Icon(Icons.arrow_downward_sharp, color: Colors.grey, size: 25),
                  );
              } else {
                debugPrint("Got nothing to show");
                return Container();
              }
            },
          ),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder<LengthModel>(
            future: postController.downvotesLength,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  debugPrint("Got error. The error is: ");
                  debugPrint(snapshot.error.toString());
                  return const Center(
                    child: Text("0"),
                  );
                } else {
                  return Text(snapshot.data!.length.toString());
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text("0"),
                );
              } else {
                debugPrint("Got nothing to show");
                return Container();
              }
            },
          )
        ],
      ),
      const Spacer(),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.green),
              ),
              child: const Text(
                'Solve',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      const SizedBox(
        width: 5,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.orange),
              ),
              child: const Text(
                'Comment',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder<LengthModel>(
            future: postController.commentsLength,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active ||
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  debugPrint("Got error. The error is: ");
                  debugPrint(snapshot.error.toString());
                  return const Center(
                    child: Text("0"),
                  );
                } else {
                  return Text(snapshot.data!.length.toString());
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text("0"),
                );
              } else {
                debugPrint("Got nothing to show");
                return Container();
              }
            },
          )
        ],
      ),
    ]);
  }
}
