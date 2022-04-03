<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Upvote;
use App\Models\Post;

class UpvoteController extends Controller
{
    public function addUpvote($post_id, $user_id)
    {
        $upvote = new Upvote;
        $post = Post::find($post_id);

        $upvote->user_id = $user_id;

        $response = $post->upvote()->save($upvote);

        if ($response) {
            return ["result" => "Upvote was successfully added"];
        } else {
            return ["result" => "Upvote couldn't be added"];
        }
    }

    public function getUpvote($id)
    {
        $data = array();
        $upvotes = Upvote::where("post_id", $id)->get();

        $user_controller = new UserController;

        foreach ($upvotes as $value) {
            $user = $user_controller->getUser($value->user_id);
            array_push($data, $user);
        }

        return ['data' => $data];
    }

    public function getUpvotesLength($id)
    {
        $upvotes = Upvote::where("post_id", $id)->get();

        $upvotes_length = count($upvotes);

        return ["length" => $upvotes_length];
    }

    public function checkUpvote($post_id, $user_id)
    {
        $response = false;
        $upvotes = Upvote::where("post_id", $post_id)->get();

        foreach ($upvotes as $value) {
            if ($value->user_id == $user_id) {
                $response = true;
            }
        }

        return ["is_upvoted" => $response];
    }

    public function deleteUpvote($post_id, $user_id)
    {
        $upvote = Upvote::where("post_id", $post_id)->where("user_id", $user_id)->first();

        $response = $upvote->delete();

        if ($response) {
            return ["result" => "Upvote was successfully deleted"];
        } else {
            return ["result" => "Upvote couldn't be deleted"];
        }
    }
}
