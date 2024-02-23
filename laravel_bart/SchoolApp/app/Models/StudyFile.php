<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StudyFile extends Model
{
    use HasFactory;

    protected $fillable = [
       
        'file_name',
        'file',
        'employee_id',
        
    ];
    
    public function classRoom()
    {
      return $this->belongsTo(ClassRoom::class);

    }
    public function studyFile()
    {
      return $this->belongsTo(StudyFile::class);

    }
}