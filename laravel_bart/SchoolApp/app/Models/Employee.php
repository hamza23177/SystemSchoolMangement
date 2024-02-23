<?php

namespace App\Models;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Tymon\JWTAuth\Contracts\JWTSubject;

class Employee extends Authenticatable implements JWTSubject
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
      'f_name',
      'm_name',
      'l_name',
      'full_name',
      'address_id',
      'birthday',
      'phone',
      'email',
      'job_type',
      'edu_degree',
      'start_date',
      'end_date',
      'time_table',
      'image',
      'active',
      'password'
  ];
  protected $guard = 'employee';
  public function address()
  {
    return $this->belongsTo(Address::class);
  
  }
  
  public function note()
  {
    return $this->hasMany(Note::class);
  
  }
  
  public function absence_Let_emp()
  {
    return $this->hasMany(Absence_Let_emp::class);
  
  }
  
  public $with=['address']; 

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

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
}