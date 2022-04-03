<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    use HasFactory;

    public function upvote()
    {
        return $this->hasMany(Upvote::class);
    }

    public function downvote()
    {
        return $this->hasMany(Downvote::class);
    }

    public function comment()
    {
        return $this->hasMany(Comment::class);
    }

    public function progress()
    {
        return $this->hasMany(Progress::class);
    }

    public function option()
    {
        return $this->hasMany(Option::class);
    }

    public function optionVote()
    {
        return $this->hasMany(OptionVote::class);
    }
}
