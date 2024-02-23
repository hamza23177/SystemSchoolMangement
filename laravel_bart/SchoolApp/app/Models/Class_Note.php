<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Class_Note extends Model
{
    use HasFactory;

    protected $fillable = [
        'note_id',
        'class_room_id',
    ];
    public function classRoom()
    {
      return $this->belongsTo(ClassRoom::class);

    }
    
    public function note()
    {
      return $this->belongsTo(Note::class);

    }
    public $with=['note']; 
}