<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Tymon\JWTAuth\Contracts\JWTSubject;
class Student extends  Authenticatable implements JWTSubject
{
    use HasFactory;
    protected $fillable = [
        'f_name',
        'm_name',
        'l_name',
        'full_name',
        'mother_name',
        'address_id',
        'birthday',
        'phone',
        'image',
        'email',
        'parent_phone',
        'class_room_id',
        'password'
        
    ];

    public function address()
    {
      return $this->belongsTo(Address::class);

    }
    public function classRoom()
    {
      return $this->belongsTo(ClassRoom::class);

    }
    public function vauationl()
    {
      return $this->hasMany(Valuation::class);

    }
   
    public function student_Note()
    {
      return $this->hasMany(Student_Note::class);

    }
    public function mark()
    {
      return $this->hasMany(Mark::class);

    }
    public function class_StudyFile()
    {
      return $this->hasMany(Class_StudyFile::class);

    }
    public function absence_Let_st()
    {
      return $this->hasMany(Absence_Let_st::class);

    }
    public $with=['address'];
       /**
     * Get the identifier that will be stored in the subject claim of the JWT.
     *
     * @return mixed
     */
    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    /**
     * Return a key value array, containing any custom claims to be added to the JWT.
     *
     * @return array
     */
    public function getJWTCustomClaims()
    {
        return [];
    }

    protected $hidden = [
      'password',
      'remember_token',
  ];
}