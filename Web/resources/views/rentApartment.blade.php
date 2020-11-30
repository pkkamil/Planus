<?php
    $active = 'rent';
?>

@extends('layouts.app')
@section('content')
    <article class="rent-apartment">
        <section class="left-part">
            <h2>Dołącz do <span class="orange-text">mieszkania</span></h2>
            <p>Skorzystaj ze specjalnego <span class="orange-text">kodu zaproszenia</span>, <br>który <span class="orange-text">właściciel</span> mieszkania może ci udostępnić.</p>
            <form method="POST" action="{{ route('joinToApartment') }}">
                @csrf
                <span class="code">
                    <i class="fas fa-house-user"></i>
                    <input id="code" type="text" @error('code') is-invalid @enderror" name="code" value="{{ old('code') }}" required placeholder="Kod zaproszenia" autocomplete="code" autofocus>
                </span>
                @error('email')
                    <span class="invalid-feedback" role="alert">
                        <p>{{ $message }}</p>
                    </span>
                @enderror
                <button type="submit">Dołącz</button>
            </form>
        </section>
        <section class="right-part">
            <img src="{{ asset('resources/img/svg/rent.svg') }}" alt="">
        </section>
    </article>
@endsection

