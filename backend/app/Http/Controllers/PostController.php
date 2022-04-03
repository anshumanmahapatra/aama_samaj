<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Post;
use App\Models\User;

class PostController extends Controller
{
    public function addPost(Request $request, $id)
    {
        $post = new Post;
        $user = User::find($id);

        $post->image_url = $request->image_url;
        $post->category = $request->category;
        $post->address = $request->address;
        $post->description = $request->description;
        $post->is_poll = $request->is_poll;
        $post->is_updated = $request->is_updated;

        $response = $user->post()->save($post);

        if ($response) {
            return ["result" => "Post was successfully added"];
        } else {
            return ["result" => "Post couldn't be added"];
        }
    }

    public function getPost()
    {
        $data = array();

        $posts = Post::all();

        $user_controller = new UserController;
        
        foreach ($posts as $value) {
            $user = $user_controller->getUser($value->user_id);
            $single_data = [
                "user" => $user,
                "post" => $value
            ];
            array_push($data, $single_data);
        }

        return ['data' => $data];
    }

    public function updatePost(Request $request)
    {
        $post = Post::find($request->id);

        $post->image_url = $request->image_url;
        $post->category = $request->category;
        $post->address = $request->address;
        $post->description = $request->description;
        $post->is_poll = $request->is_poll;
        $post->is_updated = $request->is_updated;

        $response = $post->save();

        if ($response) {
            return ["result" => "Post was successfully updated"];
        } else {
            return ["result" => "Post couldn't be updated"];
        }
    }

    public function deletePost($id)
    {
        $post = Post::find($id);

        $response = $post->delete();

        if ($response) {
            return ["result" => "Post was successfully deleted"];
        } else {
            return ["result" => "Post couldn't be deleted"];
        }
    }
}
