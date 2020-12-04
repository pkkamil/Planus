<?php
    $active = 'details';
    $diagrams = True;
?>

@extends('layouts.app')
@section('content')
    <article class="apartment-details">
        <section class="left-part">
            <h1 class="name">{{ $apartment -> name }}</h1>
            <img src="{{ $apartment -> image }}" alt="">
            <h3>Mieszkańcy</h3>
            <section class="list-of-members">
                @foreach ($apartment -> roommates as $member)
                <div class="single-member">
                    <div class="circle">{{ $member -> name[0] }}</div>
                    <p>{{ $member -> name }}</p>
                </div>
                @endforeach
                @if ($apartment -> user_id == Auth::id())
                <div class="single-member">
                    <div class="circle-add"><i class="fas fa-plus"></i></div>
                </div>
                @endif
            </section>
            <section class="bottom-part">
                @if ($days > 0)
                    <p>Do terminu rozliczenia<br>pozostało <span class="orange-text">{{ $days }}</span> dni.</p>
                @elseif ($days == -1)
                    <p><br><span class="orange-text">Dzisiaj</span> wypada termin rozliczenia.</p>
                @else
                    <p><br><span class="orange-text">Jutro</span> wypada termin rozliczenia.</p>
                @endif
                <p>@if ($interval_to_end > 0)Pozostały okres rozliczeniowy:<br>@endif<span class="orange-text">@if ($interval_to_end > 0) {{ $interval_to_end }} miesiące @endif @if ($interval_to_end > 4) miesięcy @elseif ($interval_to_end == 1) miesiąc @elseif ($interval_to_end == 0)<span style="color: #555">Jest to <span class="orange-text">ostatni miesiąc</span> rozliczeniowy</span>@elseif ($interval_to_end < 0) <span style="color: #F00">Koniec okresu rozliczeniowego</span> @endif<span></p>
            </section>
        </section>
        <section class="right-part">
            <h3>Statystyki <span class="orange-text">mieszkania</span></h3>
            <section class="statistics">
                @if ($counters < 3)
                    <h5>Brak statystyk do wyświetlenia.</h5>
                    <h6>Po 3 terminach rozliczeń zostaną one tutaj wyświetlone.</h6>
                    <img src="{{ asset('resources/img/svg/charts.svg') }}" alt="">
                @else
                    //
                @endif
                @if ($apartment -> user_id == Auth::id() and $days < 2 or $apartment -> user_id == Auth::id() and $overdue)
                    <a href="{{ url('/panel/mieszkanie/'.$apartment -> id_apartment.'/liczniki') }}"><button>Wprowadź liczniki</button></a>
                @endif
            </section>
        </section>
        <a href="{{ url('/panel') }}"><button class="back"><i class="fas fa-chevron-left"></i> Wróć do panelu</button></a>
        @if ($apartment -> user_id == Auth::id())
            <a href="{{ url('/panel/mieszkanie/'.$apartment -> id_apartment.'/edit') }}"><button class="settings-apartment"><i class="fas fa-cog"></i> Ustawienia mieszkania</button></a>
        @endif
    </article>
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
@endsection
