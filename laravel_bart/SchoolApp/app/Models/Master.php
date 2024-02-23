<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Master extends Model
{
    use HasFactory;

    protected $fillable = [
        'work_time',
        'salary',
        'employee_id',
    ];
    
    public function employee()
    {
      return $this->belongsTo(Employee::class);

    }
    public function classRoom()
    {
      return $this->hasMany(ClassRoom::class);

    }
    public $with=['employee'];
}