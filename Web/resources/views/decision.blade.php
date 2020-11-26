<?php
    $scrollTo = '';
    $active = '';
    $headerClass = 'decision';
?>
@extends('layouts.app')
@section('content')
<article class="login-section">
    <section class="image">
        <img src="{{ asset('resources/img/login-orange.png') }}" alt="">
    </section>
    <section class="form decision">
        <img src="{{ asset('resources/img/svg/decision.svg') }}" alt="">
        <p>Co chcesz zrobić?</p>
        <a href="{{ route('addApartment') }}"><button>Utwórz mieszkanie</button></a>
        <a href="{{ route('rentApartment') }}"><button>Dołącz do mieszkania</button></a>
    </section>
</article>
@endsection
