<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class ClassRoom extends Model
{
    use HasFactory;
    protected $fillable = [
        'room_name',
        'date',
        'image',
        'master_id',
        'level'
    ];
    public function master()
    {
      return $this->belongsTo(Master::class);

    }
      public function studyFile()
    {
      return $this->hasMany(StudyFile::class);

    }
    public function student()
    {
      return $this->hasMany(Student::class);

    }
    public function class_Teacher()
    {
      return $this->hasMany(Class_Teacher::class);

    }
    public function class_StudyFile()
    {
      return $this->hasMany(Class_StudyFile::class);

    }
    public function class_Note()
    {
      return $this->hasMany(Class_Note::class);

    }
    
}