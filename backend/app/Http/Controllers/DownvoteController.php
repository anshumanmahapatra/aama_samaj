<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Downvote;
use App\Models\Post;

class DownvoteController extends Controller
{
    public function addDownvote($post_id, $user_id)
    {
        $downvote = new Downvote;
        $post = Post::find($post_id);

        $downvote->user_id = $user_id;

        $response = $post->downvote()->save($downvote);

        if ($response) {
            return ["result" => "Downvote was successfully added"];
        } else {
            return ["result" => "Downvote couldn't be added"];
        }
    }

    public function getDownvote($id)
    {
        $data = array();
        $downvotes = Downvote::where("post_id", $id)->get();

        $user_controller = new UserController;

        foreach ($downvotes as $value) {
            $user = $user_controller->getUser($value->user_id);
            array_push($data, $user);
        }

        return ['data' => $data];
    }

    public function getDownvotesLength($id)
    {
        $downvotes = Downvote::where("post_id", $id)->get();

        $downvotes_length = count($downvotes);

        return ["length" => $downvotes_length];
    }

    public function checkDownvote($post_id, $user_id)
    {
        $response = false;
        $downvotes = Downvote::where("post_id", $post_id)->get();

        foreach ($downvotes as $value) {
            if ($value->user_id == $user_id) {
                $response = true;
            }
        }

        return ["is_downvoted" => $response];
    }

    public function deleteDownvote($post_id, $user_id)
    {
        $downvote = Downvote::where("post_id", $post_id)->where("user_id", $user_id)->first();

        $response = $downvote->delete();

        if ($response) {
            return ["result" => "Downvote was successfully deleted"];
        } else {
            return ["result" => "Downvote couldn't be deleted"];
        }
    }
}
