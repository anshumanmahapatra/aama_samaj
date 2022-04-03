<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\UserController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\UpvoteController;
use App\Http\Controllers\DownvoteController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\NoticeController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware(['auth:sanctum'])->group(function () {
    //Posts
    //Route for uploading post
    Route::post('/upload-post/{id}', [PostController::class, 'addPost']);
    //Route for getting post
    Route::get('/get-posts', [PostController::class, 'getPost']);
    //Route for updating post
    Route::put('/update-post', [PostController::class, 'updatePost']);
    //Route for deleting post
    Route::delete('/delete-post/{id}', [PostController::class, 'deletePost']);


    //Upvotes
    //Route for uploading upvote
    Route::post('/add-upvote/{post_id}/{user_id}', [UpvoteController::class, 'addUpvote']);
    //Route for getting upvotes
    Route::get('/get-upvotes/{id}', [UpvoteController::class, 'getUpvote']);
    //Route for getting upvotes length for specific post
    Route::get('/get-upvotes-length/{id}', [UpvoteController::class, 'getUpvotesLength']);
    //Route for checking if a user has upvoted a specific post
    Route::get('/check-is-upvoted/{post_id}/{user_id}', [UpvoteController::class, 'checkUpvote']);
    //Route for deleting upvote
    Route::delete('/delete-upvote/{post_id}/{user_id}', [UpvoteController::class, 'deleteUpvote']);


    //Downvotes
    //Route for uploading downvote
    Route::post('/add-downvote/{post_id}/{user_id}', [DownvoteController::class, 'addDownvote']);
    //Route for getting downvotes
    Route::get('/get-downvotes/{id}', [DownvoteController::class, 'getDownvote']);
    //Route for getting downvotes length for specific post
    Route::get('/get-downvotes-length/{id}', [DownvoteController::class, 'getDownvotesLength']);
    //Route for checking if a user has downvoted a specific post
    Route::get('/check-is-downvoted/{post_id}/{user_id}', [DownvoteController::class, 'checkDownvote']);
    //Route for deleting downvote
    Route::delete('/delete-downvote/{post_id}/{user_id}', [DownvoteController::class, 'deleteDownvote']);


    //Comments
    //Route for uploading comment
    Route::post('/add-comment/{id}', [CommentController::class, 'addComment']);
    //Route for getting comments
    Route::get('/get-comments/{id}', [CommentController::class, 'getComment']);
    //Route for getting comments length for specific post
    Route::get('/get-comments-length/{id}', [CommentController::class, 'getCommentsLength']);
    //Route for updating comment
    Route::put('/update-comment', [CommentController::class, 'updateComment']);
    //Route for deleting comment
    Route::delete('/delete-comment/{id}', [CommentController::class, 'deleteComment']);

    //Notices
    //Route for uploading notice
    Route::post('/add-notice/{id}', [NoticeController::class, 'addNotice']);
    //Route for getting notice
    Route::get('/get-notices', [NoticeController::class, 'getNotice']);
    //Route for updating notice
    Route::put('/update-notice', [NoticeController::class, 'updateNotice']);
    //Route for deleting notice
    Route::delete('/delete-notice/{id}', [NoticeController::class, 'deleteNotice']);


    //User
    //Route for getting a specific User
    Route::get('/get-user/{id}', [UserController::class, 'getUser']);
    //Route for updating address
    Route::patch('/update-address', [UserController::class, 'updateAddress']);
    //Route for updating image url
    Route::patch('/update-image-url', [UserController::class, 'updateImageUrl']);
    //Route for updating name
    Route::patch('/update-name', [UserController::class, 'updateName']);
    //Route for logging out user
    Route::post('/logout', [UserController::class, 'logout']);
});

//Registering
//Public Route for registering user with Email
Route::post('/register-with-email', [UserController::class, 'registerWithEmail']);
//Public Route for registering user with Google
Route::post('/register-with-google', [UserController::class, 'registerWithGoogle']);
//Public Route for registering user with Phone Number
Route::post('/register-with-phone', [UserController::class, 'registerWithPhoneNumber']);


//Logging In
//Public Route for logging in user with Email
Route::post('/login-with-email', [UserController::class, 'loginWithEmailOrGoogle']);
//Public Route for logging in user with Google
Route::post('/login-with-google', [UserController::class, 'loginWithEmailOrGoogle']);
//Public Route for logging in user with Phone Number
Route::post('/login-with-phone', [UserController::class, 'loginWithPhoneNumber']);
