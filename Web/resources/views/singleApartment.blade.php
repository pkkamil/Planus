<?php
    $scrollTo = '';
    $active = '';
    $headerClass = 'apartment';
?>

@extends('layouts.app')
@section('content')
    <article class="apartment">
        <section class="left-part">
            <h2>{{ $apartment -> name }}</h2>
            <h4>{{ $apartment -> localization }}</h4>
            <h3>Powierzchnia: {{ $apartment -> area }} m<sup>2</sup></h3>
            <h3>Liczba pokoi: {{ $apartment -> rooms }}</h3>

            <section class="down-part">
                <h3>Miesięczny koszt wynajmu: {{ $apartment -> price }} <span style="color: #999">zł</span></h3>
                <h6>+ opłata za media</h6>
                <button><a href="{{ route('informOwner') }}">Wynajmij</a></button>
            </section>
        </section>
        <section class="right-part">
            <img src="{{ $apartment -> image }}" alt="">
        </section>
    </article>
@endsection
