<?php

use App\Mail\ActivationMail;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;


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
Route::get('/mieszkanie/{id}', 'ApartmentController@show');
// Auth
Auth::routes();
Route::get('/przedstaw-sie', function() {
    if (Auth::id()) {
        if (Auth::user() -> name == Null)
            return view('auth.setName');
        else
            return redirect('/');
    }
    else
        return redirect('/login');
});
Route::post('/przedstaw-sie/sukces', 'UserController@setName')->name('introduce');

Route::get('/decyzja', function() {
    if (Auth::user()) {
    if (count(Auth::user() -> residents) == 0 or count(Auth::user() -> apartments) == 0)
        return view('decision');
    else
        return redirect('/panel');
    } else
        return redirect('/login');
});

Route::post('/mieszkanie/zapytaj', 'ApartmentController@inform')->middleware('auth')->name('informOwner');

Route::middleware(['introduced', 'auth'])->group(function () {
    Route::view('/panel/wynajmij', 'rentApartment')->name('rentApartment');
    Route::post('/panel/wynajmij', 'ApartmentController@rent')->name('joinToApartment');
    Route::view('/panel/dodaj', 'addApartment')->name('addApartment');
    Route::post('/panel/dodaj', 'ApartmentController@add')->name('add');

    Route::middleware(['decided'])->group(function () {
        Route::get('/panel', 'DashboardController@index')->name('dashboard');
        Route::get('/panel/wszystkie-mieszkania', 'DashboardController@showAll')->name('showAll');


        Route::get('/panel/mieszkanie/{id}', 'ApartmentController@apartmentDetails');
        Route::post('/panel/mieszkanie/{id}/nowy_mieszkaniec', 'ApartmentController@createMember');
        Route::get('/panel/mieszkanie/{id}/usun_mieszkanca/{user_id}', 'ApartmentController@deleteMember');
        Route::get('/panel/mieszkanie/{id}/edycja', 'ApartmentController@editPage');
        Route::post('/panel/mieszkanie/edycja', 'ApartmentController@edit')->name('edit');
        Route::get('/panel/mieszkanie/{id}/usun_mieszkanie', 'ApartmentController@delete');

        Route::get('/panel/mieszkanie/{id}/rachunki', 'BillController@index');

        Route::get('/panel/mieszkanie/{id}/liczniki', 'CounterController@create');
        Route::post('/panel/mieszkanie/liczniki', 'CounterController@store')->name('enterCounters');

        Route::view('/panel/ustawienia', 'settingsAccount');
        Route::post('/panel/ustawienia/zmiana_nazwy', 'UserController@changeName')->name('changeName');
        Route::post('/panel/ustawienia/zmiana_adresu_email', 'UserController@changeEmail')->name('changeEmail');
        Route::post('/panel/ustawienia/zmiana_hasla', 'UserController@changePassword')->name('changePassword');

        Route::get('/panel/mieszkanie/{id}/wstepne_liczniki', 'CounterController@firstInput');
        Route::post('/panel/mieszkanie/wstepne_liczniki', 'CounterController@initialCounters')->name('initialCounters');
    });
});

Route::get('/diagrams/{diagram}/{id}', 'ChartController@diagrams');
Route::get('/diagrams/last-month/{id}', 'ChartController@lastMonth');
Route::view('/chart', 'chart');

// Route::get('/test3', 'ApartmentController@code');

Route::get('/chart/data/consumption/{id}/{type}', 'ChartController@consumptions');

Route::get('/send-mail', function () {
    Mail::to('kamiliked11@gmail.com')->send(new ActivationMail());
    return 'A message has been sent!';
});
