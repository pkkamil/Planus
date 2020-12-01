<?php
    $active = 'details';
?>

@extends('layouts.app')
@section('content')
    <article class="apartment-details">
        @if ($apartment -> user_id == Auth::id())
            <section class="left-part">
                <h1 class="name">{{ $apartment -> name }}</h1>
                <img src="{{ $apartment -> image }}" alt="">
                <h3>Mieszkańcy</h3>
                <section class="list-of-members">
                    <div class="single-member">
                        <div class="circle">{{ Auth::user() -> name[0] }}</div>
                        <p>{{ Auth::user() -> name }}</p>
                    </div>
                    <div class="single-member">
                        <div class="circle-add"><i class="fas fa-plus"></i></div>
                    </div>
                </section>
                <section class="bottom-part">
                    <p>Do terminu rozliczenia<br>pozostało <span class="orange-text">10</span> dni.</p>
                    <p>Pozostały okres rozliczeniowy:<br><span class="orange-text">24 miesiące</span></p>
                </section>
            </section>
            <section class="right-part">
                <h3>Statystyki <span class="orange-text">mieszkania</span></h3>
                <a href="{{ url('/panel/mieszkanie/'.$apartment -> id_apartment.'/liczniki') }}"><button>Wprowadź liczniki</button></a>
            </section>
            <a href="{{ url('/panel') }}"><button class="back"><i class="fas fa-chevron-left"></i> Wróć do panelu</button></a>
            <a href="{{ url('/panel/mieszkanie/'.$apartment -> id_apartment.'/edit') }}"><button class="settings-apartment"><i class="fas fa-cog"></i> Ustawienia mieszkania</button></a>
        @else
            <section class="left-part">
                <h1 class="name">{{ $apartment -> name }}</h1>
                <img src="{{ $apartment -> image }}" alt="">
                <h3>Mieszkańcy</h3>
                <section class="list-of-members">
                    <div class="single-member">
                        <div class="circle">{{ Auth::user() -> name[0] }}</div>
                        <p>{{ Auth::user() -> name }}</p>
                    </div>
                    <div class="single-member">
                        <div class="circle">{{ 'J' }}</div>
                        <p>{{ 'Josh' }}</p>
                    </div>
                    <div class="single-member">
                        <div class="circle">{{ 'R' }}</div>
                        <p>{{ 'Radosław' }}</p>
                    </div>
                </section>

                <section class="bottom-part">
                    <p>Do terminu rozliczenia<br>pozostało <span class="orange-text">10</span> dni.</p>
                    <p>Pozostały okres rozliczeniowy:<br><span class="orange-text">24 miesiące</span></p>
                </section>
            </section>
            <section class="right-part">
                <h3>Statystyki <span class="orange-text">mieszkania</span></h3>
            </section>
            <a href="{{ url('/panel') }}"><button class="back"><i class="fas fa-chevron-left"></i> Wróć do panelu</button></a>
            <a href="{{ url('/panel/mieszkanie/'.$apartment -> id_apartment.'/rachunki') }}"><button class="bills"><i class="fas fa-wallet"></i> Rachunki</button></a>
        @endif
    </article>
@endsection
