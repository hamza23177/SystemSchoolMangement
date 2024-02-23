<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Address extends Model
{
    use HasFactory;

    protected $fillable = [
        'city',
        'region',
        'street',
        'bulid_num'
    ];

    public function student()
    {
      return $this->hasMany(Student::class);

    }
    public function employee()
    {
      return $this->hasMany(Employee::class);

    }
   
}