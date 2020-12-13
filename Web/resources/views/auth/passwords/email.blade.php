<?php
    $scrollTo = '';
    $active = 'login';
    $headerClass = 'reset';
    $title = 'Resetowanie hasła | Planus';
?>
@extends('layouts.app')
@section('content')
<article class="login-section">
    <section class="image">
        <img src="{{ asset('resources/img/login-orange.png') }}" alt="">
    </section>
    <section class="form">
        <img src="{{ asset('resources/img/svg/reset.svg') }}" alt="">
        <form method="POST" action="{{ route('password.email') }}">
            @csrf
            @if (session('status'))
                <div class="alert alert-success" role="alert">
                    {{ session('status') }}
                </div>
            @endif
            <span class="email">
                <i class="fas fa-user"></i>
                <input id="email" type="email" @error('email') is-invalid @enderror" name="email" value="{{ old('email') }}" required placeholder="E-mail" autocomplete="email" autofocus>
            </span>
            @error('email')
                <span class="invalid-feedback" role="alert">
                    <p>{{ $message }}</p>
                </span>
            @enderror
            <span class="remember"></span>
            <button type="submit">Zresetuj hasło</button>
            @if (Route::has('register'))
                <a href="{{ route('register') }}">Nie masz jeszcze konta?</a>
            @endif
        </form>
    </section>
</article>
@endsection
