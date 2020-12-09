<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateBillsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('bills', function (Blueprint $table) {
            $table->id('id_bill');
            $table->decimal('sum', 10,2);
            $table->decimal('rental_price', 10,2);
            $table->decimal('cold_water', 10,2)->nullable();
            $table->decimal('hot_water', 10,2)->nullable();
            $table->decimal('gas', 10,2)->nullable();
            $table->decimal('electricity', 10,2)->nullable();
            $table->decimal('rubbish', 10,2)->nullable();
            $table->decimal('internet', 10,2)->nullable();
            $table->decimal('tv', 10,2)->nullable();
            $table->decimal('phone', 10,2)->nullable();
            $table->integer('id_apartment');
            $table->timestamp('settlement_date');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('bills');
    }
}
