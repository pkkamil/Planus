<?php
    $active = 'dashboard';
?>

@extends('layouts.app')
@section('content')
    <article class="activity-center show-all">
        <a class="button back" href="{{ url('/panel') }}"><i class="fas fa-chevron-left"></i> Wróć</a>
        <h2>Witaj, <span class="orange-text">{{ Auth::user() -> name }}</span>! <i class="far fa-bell"></i></h2>
        <h4>Twoje <span class="orange-text">mieszkania</span></h4>
            <section class="list-apartments">
                @foreach($apartments as $apartment)
                    <section class="single-apartment smaller">
                        <a href="{{ url("panel/mieszkanie/".$apartment -> id_apartment) }}">
                            <img src="{{ $apartment -> image }}" alt="">
                            <h3>{{ $apartment -> name }}</h3>
                            <section class="layer">
                                <h4>Więcej szczegółów</h4>
                            </section>
                        </a>
                    </section>
                @endforeach
            </section>
    </article>
@endsection
