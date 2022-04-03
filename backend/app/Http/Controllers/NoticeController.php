<?php

namespace App\Http\Controllers;

use App\Models\Notice;
use App\Models\User;

use Illuminate\Http\Request;

class NoticeController extends Controller
{
    public function addNotice(Request $request, $id)
    {
        $notice = new Notice;
        $user = User::find($id);

        $notice->image_url = $request->image_url;
        $notice->title = $request->title;
        $notice->address = $request->address;
        $notice->description = $request->description;
        $notice->is_poll = $request->is_poll;
        $notice->is_updated = $request->is_updated;

        $response = $user->notice()->save($notice);

        if ($response) {
            return ["result" => "Notice was successfully added"];
        } else {
            return ["result" => "Notice couldn't be added"];
        }
    }

    public function getNotice()
    {
        $data = array();

        $notices = Notice::all();

        $user_controller = new UserController;

        foreach ($notices as $value) {
            $user = $user_controller->getUser($value->user_id);
            $single_data = [
                "user" => $user,
                "notice" => $value
            ];
            array_push($data, $single_data);
        }
        return ['data' => $data];
    }

    public function updateNotice(Request $request)
    {
        $notice = Notice::find($request->id);

        $notice->image_url = $request->image_url;
        $notice->title = $request->title;
        $notice->address = $request->address;
        $notice->description = $request->description;
        $notice->is_poll = $request->is_poll;
        $notice->is_updated = $request->is_updated;

        $response = $notice->save();

        if ($response) {
            return ["result" => "Notice was successfully updated"];
        } else {
            return ["result" => "Notice couldn't be updated"];
        }
    }

    public function deleteNotice($id)
    {
        $notice = Notice::find($id);

        $response = $notice->delete();

        if ($response) {
            return ["result" => "Notice was successfully deleted"];
        } else {
            return ["result" => "Notice couldn't be deleted"];
        }
    }
}
