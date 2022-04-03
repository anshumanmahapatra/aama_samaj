<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notice extends Model
{
    use HasFactory;

    public function option()
    {
        return $this->hasMany(NoticeOption::class);
    }

    public function optionVote()
    {
        return $this->hasMany(NoticeOptionVote::class);
    }
}
