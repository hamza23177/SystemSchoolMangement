<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('class__notes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('class_room_id');
            $table->foreign('class_room_id')->references('id')->on('class_rooms');
            $table->unsignedBigInteger('note_id');
            $table->foreign('note_id')->references('id')->on('notes');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('class__notes');
    }
};