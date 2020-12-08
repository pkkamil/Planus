<?php
    $active = 'dashboard';
    $diagrams = True;
?>

@extends('layouts.app')
@section('content')
    <article class="activity-center">
        <section class="left-part">
            <h2>Witaj, <span class="orange-text">{{ Auth::user() -> name }}</span>! <i class="far fa-bell"></i></h2>
            <h4>Twoje <span class="orange-text">mieszkania</span></h4>
                <section class="list-apartments">
                    @if (count($apartments) == 1)
                    <section class="single-apartment">
                        <a href="{{ url("panel/mieszkanie/".$apartments -> id_apartment) }}">
                            <img src="{{ $apartments -> image }}" alt="">
                            <h3>{{ $apartments -> name }}</h3>
                            <section class="layer">
                                <h4>Więcej szczegółów</h4>
                            </section>
                        </a>
                    </section>
                    @else
                        @foreach($apartments as $apartment)
                            @if ($loop -> index < 2)
                            <section class="single-apartment smaller">
                                <a href="{{ url("panel/mieszkanie/".$apartment -> id_apartment) }}">
                                    <img src="{{ $apartment -> image }}" alt="">
                                    <h3>{{ $apartment -> name }}</h3>
                                    <section class="layer">
                                        <h4>Więcej szczegółów</h4>
                                    </section>
                                </a>
                            </section>
                            @endif
                        @endforeach
                    @endif
                </section>
                @if (count($apartments) > 2)
                    <a href="{{ route('showAll') }}"><button>Zobacz wszystkie</button></a>
                @endif
                @if (count($apartments) == 1)
                    <h3>Mieszkańcy</h3>
                    <section class="list-of-members">
                        <div class="single-member">
                            <div class="circle">{{ Auth::user() -> name[0] }}</div>
                        </div>
                      </section>
                @else
                    <h4 class="events">Nadchodzące <span class="orange-text">zdarzenia</span></h3>
                    <ul class="list-of-events">
                        @foreach ($soon as $el)
                            <li>{!! $el !!},</li>
                        @endforeach
                    </ul>
                @endif
        </section>
        <section class="right-part">
            @if (count($apartments) == 1)
            <h4>Miesięczne <span class="orange-text">koszty</span></h4>
            <div id="chart" style="height: 350px; width: 550px"></div>
            @else
            <img src="{{ asset('resources/img/svg/dashboard.svg') }}" alt="">
            @endif
        </section>
        <a href="{{ url('/panel/ustawienia') }}"><button class="settings"><i class="fas fa-cog"></i> Ustawienia konta</button></a>
    </article>
    @if (count($apartments) == 1)
        <script>
            const chart3 = new Chartisan({
                el: '#chart',
                url: 'http://planus.me/test/4',
                hooks: new ChartisanHooks()
                    .legend(false)
                    .beginAtZero()
                    .colors(['#FFA500']),
            })
        </script>
    @endif
@endsection
