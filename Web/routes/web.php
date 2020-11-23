<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', 'ApartmentController@index');

Route::get('/apartment/rent', 'ApartmentController@rent')->name('rentApartment');
Route::get('/apartment/add', 'ApartmentController@add')->name('addApartment');

Auth::routes();

Route::get('/panel', 'DashboardController@index')->name('dashboard');
