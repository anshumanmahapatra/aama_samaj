<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Option;
use App\Models\Post;

class OptionController extends Controller
{
    public function addOption(Request $request, $id)
    {
        $option = new Option;
        $post = Post::find($id);

        $option->option_1 = $request->option_1;
        $option->option_2 = $request->option_2;
        $option->option_3 = $request->option_3;
        $option->option_4 = $request->option_4;

        $response = $post->option()->save($option);

        if ($response) {
            return ["result" => "Options were successfully added"];
        } else {
            return ["result" => "Options couldn't be added"];
        }
    }

    public function getOption($id)
    {
        $option = Option::where("post_id", $id)->get();

        return ["data" => $option];
    }

    public function updateOptionVotes(Request $request)
    {
        $option = Option::where('post_id', $request->post_id);

        $option->increment('total_votes');
        if ($request->option_id == 1) {
            $option->increment('option_1_votes');
        } else if ($request->option_id == 2) {
            $option->increment('option_2_votes');
        } else if ($request->option_id == 3) {
            $option->increment('option_3_votes');
        } else {
            $option->increment('option_4_votes');
        }

        $response = $option->save();

        if ($response) {
            return ["result" => "Option was successfully updated"];
        } else {
            return ["result" => "Option couldn't be updated"];
        }
    }

    public function deleteOptionVotes(Request $request)
    {
        $option = Option::where('post_id', $request->post_id);

        $option->decrement('total_votes');
        if ($request->option_id == 1) {
            $option->decrement('option_1_votes');
        } else if ($request->option_id == 2) {
            $option->decrement('option_2_votes');
        } else if ($request->option_id == 3) {
            $option->decrement('option_3_votes');
        } else {
            $option->decrement('option_4_votes');
        }

        $response = $option->save();

        if ($response) {
            return ["result" => "Option was successfully updated"];
        } else {
            return ["result" => "Option couldn't be updated"];
        }
    }
}
