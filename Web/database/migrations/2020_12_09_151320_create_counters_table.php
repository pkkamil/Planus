<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCountersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('counters', function (Blueprint $table) {
            $table->id();
            $table->decimal('cold_water', 10,2)->nullable();
            $table->decimal('hot_water', 10,2)->nullable();
            $table->decimal('gas', 10,2)->nullable();
            $table->decimal('electricity', 10,2)->nullable();
            $table->integer('id_apartment');
            $table->integer('id_bill')->nullable();
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
        Schema::dropIfExists('counters');
    }
}
