<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Class_Teacher extends Model
{
    use HasFactory;
    
    protected $fillable = [
        'teacher_id',
        'class_room_id',
    ];
    
    public function classRoom()
    {
      return $this->belongsTo(ClassRoom::class);

    }
    public function teacher()
    {
      return $this->belongsTo(Teacher::class);

    }
}