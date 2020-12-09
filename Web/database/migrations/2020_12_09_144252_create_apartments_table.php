<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateApartmentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('apartments', function (Blueprint $table) {
            $table->id('id_apartment');
            $table->string('name', 50);
            $table->string('localization', 50);
            $table->decimal('price', 10,2);
            $table->string('image', 150);
            $table->integer('area');
            $table->integer('rooms');
            $table->integer('settlement_day');
            $table->integer('billing_period');
            $table->decimal('cold_water', 10,2)->nullable();
            $table->decimal('hot_water', 10,2)->nullable();
            $table->decimal('gas', 10,2)->nullable();
            $table->decimal('electricity', 10,2)->nullable();
            $table->decimal('rubbish', 10,2)->nullable();
            $table->decimal('internet', 10,2)->nullable();
            $table->decimal('tv', 10,2)->nullable();
            $table->decimal('phone', 10,2)->nullable();
            $table->boolean('public')->default(1);
            $table->string('invite_code', 8);
            $table->integer('user_id');
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
        Schema::dropIfExists('Apartments');
    }
}
