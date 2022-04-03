<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\User;


class UserController extends Controller
{
    public function registerWithEmail(Request $request)
    {

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'service_provider' => $request->service_provider,
        ]);


        $token = $user->createToken(mt_rand(1000000000, 9999999999))->plainTextToken;

        return response([
            'user' => $user,
            'token' => $token,
        ], 201);
    }

    public function registerWithGoogle(Request $request)
    {
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'image_url' => $request->image_url,
            'service_provider' => $request->service_provider,
        ]);

        $token = $user->createToken(mt_rand(1000000000, 9999999999))->plainTextToken;

        return response([
            'user' => $user,
            'token' => $token,
        ], 201);
    }

    public function registerWithPhoneNumber(Request $request)
    {

        $user = User::create([
            'name' => $request->name,
            'phone_number' => $request->phone_number,
            'service_provider' => $request->service_provider
        ]);

        $token = $user->createToken(mt_rand(1000000000, 9999999999))->plainTextToken;

        return response([
            'user' => $user,
            'token' => $token,
        ], 201);
    }

    public function logout()
    {
        auth()->user()->tokens()->delete();
        //Ignore the error of tokens shown here
        //It doesn't hamper anything
        return [
            "result" => "Successfully logged out"
        ];
    }

    public function loginWithEmailOrGoogle(Request $request)
    {

        $user = User::where('email', $request->email)->first();


        $token = $user->createToken(mt_rand(1000000000, 9999999999))->plainTextToken;

        return response([
            'user' => $user,
            'token' => $token,
        ], 200);
    }

    public function loginWithPhoneNumber(Request $request)
    {

        $user = User::where('phone_number', $request->phone_number)->first();


        $token = $user->createToken(mt_rand(1000000000, 9999999999))->plainTextToken;

        return response([
            'user' => $user,
            'token' => $token,
        ], 200);
    }

    public function getUser($id)
    {
        $user = User::find($id);
        return $user;
    }

    public function updateAddress(Request $request)
    {
        $user = User::find($request->id);

        $user->address = $request->address;
        $response = $user->save();

        if ($response) {
            return ["result" => "Address was successfully updated"];
        } else {
            return ["result" => "Address couldn't be updated"];
        }
    }

    public function updateImageUrl(Request $request)
    {
        $user = User::find($request->id);

        $user->image_url = $request->image_url;
        $response = $user->save();

        if ($response) {
            return ["result" => "Image was successfully updated"];
        } else {
            return ["result" => "Image couldn't be updated"];
        }
    }

    public function updateName(Request $request)
    {
        $user = User::find($request->id);

        $user->name = $request->name;
        $response = $user->save();

        if ($response) {
            return ["result" => "Name was successfully updated"];
        } else {
            return ["result" => "Name couldn't be updated"];
        }
    }
}
