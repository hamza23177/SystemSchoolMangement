<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Absence_Let_st extends Model
{
    use HasFactory;

    protected $fillable = [
        'type',
        'student_id',
        
    ];
    public function student()
    {
      return $this->belongsTo(Student::class);

    }
}