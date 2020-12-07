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
Route::post('set-name', 'api\AuthController@setName');
Route::post('change-name', 'api\AuthController@changeName');
Route::post('change-email', 'api\AuthController@changeEmail');
Route::post('account/delete', 'api\AuthController@delete');
Route::post('change-password', 'api\AuthController@changePassword');
Route::post('login', 'api\AuthController@login');
Route::get('apartments/{id?}', 'api\ApartmentApiController@index');
Route::get('apartments/paginate/{items?}', 'api\ApartmentApiController@paginate');
Route::post('apartment/create', 'api\ApartmentApiController@create');
Route::post('apartment/edit', 'api\ApartmentApiController@edit');
Route::post('apartment/member/create', 'api\ApartmentApiController@createMember');
Route::post('apartment/member/delete', 'api\ApartmentApiController@deleteMember');
Route::post('apartment/delete', 'api\ApartmentApiController@delete');
Route::post('apartment/rent', 'api\ApartmentApiController@rent');
Route::post('apartment/enter-counters', 'api\CounterApiController@store');
Route::post('apartment/enter-initial-counters', 'api\CounterApiController@initialCounters');
Route::get('apartment/last-counter/{id}', 'api\CounterApiController@index');
