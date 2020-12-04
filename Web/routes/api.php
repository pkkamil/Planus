<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// Route::middleware('auth:api')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::post('register', 'api\AuthController@register');
Route::post('setName', 'api\AuthController@setName');
Route::post('login', 'api\AuthController@login');
Route::get('apartments/{id?}', 'api\ApartmentApiController@index');
Route::get('apartments/paginate/{items?}', 'api\ApartmentApiController@paginate');
Route::post('apartment/create', 'api\ApartmentApiController@create');
Route::post('apartment/rent', 'api\ApartmentApiController@rent');
Route::post('apartment/enter-counters', 'api\CounterApiController@store');
Route::get('apartment/last-counter/{id}', 'api\CounterApiController@index');
