<?php
    $scrollTo = '';
    $active = 'register';
    $headerClass = 'register';
    $title = 'Rejestracja | Planus';
?>
@extends('layouts.app')
@section('content')
<article class="login-section">
    <section class="image">
        <img src="{{ asset('resources/img/login-orange.png') }}" alt="">
    </section>
    <section class="form">
        <img src="{{ asset('resources/img/svg/register.svg') }}" alt="">
        <form method="POST" action="{{ route('register') }}">
            @csrf
            <span class="email">
                <i class="fas fa-user"></i>
                <input id="email" type="email" @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required placeholder="E-mail" autocomplete="email" autofocus>
            </span>
            @error('email')
                <span class="invalid-feedback" role="alert">
                    <p>{{ $message }}</p>
                </span>
            @enderror
            <span class="password">
                <i class="fas fa-lock"></i>
                <input id="password" type="password" @error('password') is-invalid @enderror" name="password" required placeholder="Hasło" autocomplete="current-password">
            </span>
            @error('password')
                <span class="invalid-feedback" role="alert">
                    <p>{{ $message }}</p>
                </span>
            @enderror
            <span class="password">
                <i class="fas fa-lock"></i>
                <input id="password-confirm" type="password" @error('password') is-invalid @enderror" name="password_confirmation" required placeholder="Potwierdzenie hasła" autocomplete="new-password">
            </span>
            <span class="remember"></span>
            <button type="submit">Zarejestruj się</button>
            @if (Route::has('login'))
                <a href="{{ route('login') }}">Posiadasz już konto?</a>
            @endif
        </form>
    </section>
</article>
@endsection
