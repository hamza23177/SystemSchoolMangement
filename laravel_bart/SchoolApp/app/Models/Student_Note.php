<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Student_Note extends Model
{
    use HasFactory;
    
    protected $fillable = [
        'note_id',
        'student_id',
        
    ];
    
    public function note()
    {
      return $this->belongsTo(Note::class);

    }
    public function student()
    {
      return $this->belongsTo(Student::class);

    }
    public $with=['note']; 
}