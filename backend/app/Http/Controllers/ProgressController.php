<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Progress;
use App\Models\Post;

class ProgressController extends Controller
{
    public function addProgress(Request $request, $id)
    {
        $progress = new Progress;
        $post = Post::find($id);

        $progress->image_url = $request->image_url;
        $progress->title = $request->title;
        $progress->description = $request->description;
        $progress->user_id = $request->user_id;

        $response = $post->progress()->save($progress);

        if ($response) {
            return ["result" => "Progress was successfully added"];
        } else {
            return ["result" => "Progress couldn't be added"];
        }
    }

    public function getProgress($id)
    {
        $data = array();
        
        $progress = Progress::where("post_id", $id)->get();

        $user_controller = new UserController;
        
        foreach ($progress as $value) {
            $user = $user_controller->getUser($value->user_id);
            $single_data = [
                "user" => $user,
                "progress" => $value
            ];
            array_push($data, $single_data);
        }

        return ['data' => $data];
    }
}
