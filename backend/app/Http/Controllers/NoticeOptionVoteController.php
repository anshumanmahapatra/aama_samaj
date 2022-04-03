<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\NoticeOptionVote;
use App\Models\Notice;

class NoticeOptionVoteController extends Controller
{
    public function addOptionVote(Request $request)
    {
        $optionVote = new NoticeOptionVote;
        $post = Notice::find($request->post_id);

        $optionVote->user_id = $request->user_id;
        $optionVote->option_id = $request->option_id;

        $response = $post->optionVote()->save($optionVote);

        if ($response) {
            return ["result" => "Option Vote was successfully updated"];
        } else {
            return ["result" => "Option Vote couldn't be updated"];
        }
    }

    public function getOptionVote($post_id, $option_id)
    {
        $data = array();
        $optionVotes = NoticeOptionVote::where("post_id", $post_id)->where("option_id", $option_id)->get();

        $user_controller = new UserController;

        foreach ($optionVotes as $value) {
            $user = $user_controller->getUser($value->user_id);
            array_push($data, $user);
        }

        return ['data' => $data];
    }

    public function checkHasVoted($notice_id, $user_id)
    {
        $option_id = array(1, 2, 3, 4);
        $response = false;

        foreach ($option_id as $value) {
            $optionVote = NoticeOptionVote::where("post_id", $notice_id)
                ->where("option_id", $value)
                ->where("user_id", $user_id)
                ->first();

            if ($optionVote) {
                $response = true;
            }
        }

        return [
            "has_voted" => $response,
            "option_id" => $option_id
        ];
    }

    public function deleteOptionVote(Request $request)
    {

        $optionVote = NoticeOptionVote::where("post_id", $request->post_id)
            ->where("option_id", $request->option_id)
            ->where("user_id", $request->user_id)
            ->first();

        $response = $optionVote->delete();

        if ($response) {
            return ["result" => "Option Vote was successfully deleted"];
        } else {
            return ["result" => "Option Vote couldn't be deleted"];
        }
    }
}
