<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AffiliationRequestEmployee extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'phone',
        'name_degree',
        'target_job',
        'subject_target',
        'cv'
    ];
    
}