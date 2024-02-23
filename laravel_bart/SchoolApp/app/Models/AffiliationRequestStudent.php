<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AffiliationRequestStudent extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'phone',
        'last_level',
        'last_level_degree',
        'target_level'
    ];
}