<?php
    $scrollTo = '';
    $active = 'login';
    $headerClass = 'introduce';
    $title = 'Przedstaw się | Planus';
?>
@extends('layouts.app')
@section('content')
<article class="login-section">
    <section class="image">
        <img src="{{ asset('resources/img/login-orange.png') }}" alt="">
    </section>
    <section class="form">
        <img src="{{ asset('resources/img/svg/introduce.svg') }}" alt="">
        <form method="POST" action="{{ route('introduce') }}">
            @csrf
            <span class="name">
                <i class="fas fa-user"></i>
                <input id="name" type="text" @error('name') is-invalid @enderror" name="name" value="{{ old('name') }}" required placeholder="Imie" autofocus>
            </span>
            @error('name')
                <span class="invalid-feedback" role="alert">
                    <p>{{ $message }}</p>
                </span>
            @enderror
            <span class="remember"></span>
            <button type="submit">Zapisz</button>
        </form>
    </section>
</article>
@endsection
