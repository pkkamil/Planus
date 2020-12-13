<?php
    $scrollTo = '';
    $active = 'login';
    $headerClass = 'login';
    $title = 'Logowanie | Planus';
?>
@extends('layouts.app')
@section('content')
<article class="login-section">
    <section class="image">
        <img src="{{ asset('resources/img/login-orange.png') }}" alt="">
    </section>
    <section class="form">
        <img src="{{ asset('resources/img/svg/login.svg') }}" alt="">
        <form method="POST" action="{{ route('login') }}">
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
            <span class="remember">
                <input type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>
                <label for="remember">Zapamiętaj hasło</label>
            </span>
            <button type="submit">Zaloguj się</button>

            @if (Route::has('password.request'))
                <a href="{{ route('password.request') }}">Zapomniałeś hasło?</a>
            @endif
            @if (Route::has('register'))
                <a href="{{ route('register') }}">Nie masz jeszcze konta?</a>
            @endif
        </form>
    </section>
</article>
@endsection
