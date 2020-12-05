<?php
    $active = 'account-settings';
?>

@extends('layouts.app')
@section('content')
    <article class="settings-account">
        <section class="left-part">

        </section>
        <form action="{{ route('changeName') }}">
            @csrf
            <h1>Witaj, <input type="text" id="name" name="name" value="{{ Auth::user() -> name }}">!</h1>
        </form>
        <h3>Twój obecny adres email to <span class="orange-text">{{ Auth::user() -> email }}</span></h3>
        <h2>Zmiana twojego <span class="orange-tex">adresu email</span></h2>
        <form action="{{ route('changeEmail') }}">
            @csrf
            <label for="email">Nowy adres email</label>
            <input type="email" name="email" id="email">
            <button type="submit">Zmień adres email</button>
        </form>
        <h2>Zmiana twojego <span class="orange-tex">hasła</span></h2>
        <form action="{{ route('changePassword') }}">
            @csrf
            <label for="current_password">Obecne hasło</label>
            <input type="password" name="current_password" id="current_password">
            <label for="current_password">Nowe hasło</label>
            <input type="password" name="new_password" id="new_password">
            <label for="current_password">Potwierdzenie hasła</label>
            <input type="password" name="confirm_password" id="confirm_password">
            <button type="submit">Zmień hasło</button>
        </form>
        <section class="right-part">
            <img src="{{ asset('resources/img/svg/settings.svg') }}" alt="">
        </section>
        <a href="{{ url('/panel') }}"><button class="back"><i class="fas fa-chevron-left"></i> Wróć do panelu</button></a>
        <a href="{{ url('/panel/ustawienia/usun_konto') }}"><button class="delete_account"><i class="fas fa-trash"></i> Usuń konto</button></a>
        {{-- <a href="{{ url('/panel/ustawienia/usun_konto') }}"><button class="delete_account"><i class="far fa-trash-alt"></i> Usuń konto</button></a> --}}
    </article>
@endsection
