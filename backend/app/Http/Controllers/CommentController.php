<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Comment;
use App\Models\Post;

class CommentController extends Controller
{
    public function addComment(Request $request, $id)
    {
        $comment = new Comment;
        $post = Post::find($id);

        $comment->user_id = $request->user_id;
        $comment->description = $request->description;
        $comment->is_updated = $request->is_updated;

        $response = $post->comment()->save($comment);

        if ($response) {
            return ["result" => "Comment was successfully added"];
        } else {
            return ["result" => "Comment couldn't be added"];
        }
    }

    public function getComment($id)
    {
        $data = array();

        $comments = Comment::where("post_id", $id)->get();

        $user_controller = new UserController;

        foreach ($comments as $value) {
            $user = $user_controller->getUser($value->user_id);
            $single_data = [
                "user" => $user,
                "comment" => $value
            ];
            array_push($data, $single_data);
        }

        return ['data' => $data];
    }

    public function getCommentsLength($id)
    {
        $comments = Comment::where("post_id", $id)->get();

        $comments_length = count($comments);

        return ["length" => $comments_length];
    }

    public function updateComment(Request $request)
    {
        $comment = Comment::find($request->id);

        $comment->description = $request->description;
        $comment->is_updated = $request->is_updated;

        $response = $comment->save();

        if ($response) {
            return ["result" => "Comment was successfully updated"];
        } else {
            return ["result" => "Comment couldn't be updated"];
        }
    }

    public function deleteComment($id)
    {
        $comment = Comment::find($id);

        $response = $comment->delete();

        if ($response) {
            return ["result" => "Comment was successfully deleted"];
        } else {
            return ["result" => "Comment couldn't be deleted"];
        }
    }
}
