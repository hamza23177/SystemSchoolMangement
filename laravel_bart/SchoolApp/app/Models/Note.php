<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Note extends Model
{
    use HasFactory;
    protected $fillable = [
        'note',
        'employee_id',
    ];
    
    public function employee()
    {
      return $this->belongsTo(Employee::class);

    }
    public function student_Note()
    {
      return $this->hasMany(Student_Note::class);

    }
    public function class_Note()
    {
      return $this->hasMany(Class_Note::class);

    }
}