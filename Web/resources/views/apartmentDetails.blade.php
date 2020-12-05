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
                <p>@if ($interval_to_end > 0)Pozostały okres rozliczeniowy:<br>@endif<span class="orange-text">@if ($interval_to_end > 0) {{ $interval_to_end }} @endif @if ($interval_to_end > 1 and $interval_to_end < 4) miesiące @endif @if ($interval_to_end > 4) miesięcy @elseif ($interval_to_end == 1) miesiąc @elseif ($interval_to_end == 0)<span style="color: #555">Jest to <span class="orange-text">ostatni miesiąc</span> rozliczeniowy</span>@elseif ($interval_to_end < 0) <span style="color: #F00">Koniec okresu rozliczeniowego</span> @endif<span></p>
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
                    <section class="diagrams">
                        <section class="single-chart">
                            <h6><span class="orange-text">Wysokość rachunku</span> mieszkania<br>w ciągu ostatnich miesięcy</h6>
                            <div id="chart" style="width: 250px; height: 200px"></div>
                        </section>
                        @if ($apartment -> cold_water)
                            <section class="single-chart">
                                <h6>Koszt <span style="color: #45D8E1">wody zimnej</span><br>w ciągu ostatnich miesięcy</h6>
                                <div id="chart2" style="width: 250px; height: 200px"></div>
                            </section>
                        @endif
                        @if (!$apartment -> hot_water)
                            <section class="single-chart">
                                <h6>Koszt <span style="color: #F00">wody ciepłej</span><br>w ciągu ostatnich miesięcy</h6>
                                <div id="chart3" style="width: 250px; height: 200px"></div>
                            </section>
                        @endif
                        @if ($apartment -> gas)
                            <section class="single-chart">
                                <h6>Koszt <span style="color: #56CA53">gazu</span><br>w ciągu ostatnich miesięcy</h6>
                                <div id="chart4" style="width: 250px; height: 200px"></div>
                            </section>
                        @endif
                        @if ($apartment -> electricity)
                            <section class="single-chart">
                                <h6>Koszt <span style="color: #FFD600">prądu</span><br>w ciągu ostatnich miesięcy</h6>
                                <div id="chart5" style="width: 250px; height: 200px"></div>
                            </section>
                        @endif
                    </section>
                @endif
            <section class="bottom-part">
                <a class="bills" href="{{ url('/panel/mieszkanie/'.$apartment -> id_apartment.'/rachunki') }}"><button><i class="fas fa-money-bill-alt"></i> Rachunki</button></a>
                @if ($apartment -> user_id == Auth::id() and $days < 2 or $apartment -> user_id == Auth::id() and $overdue)
                    <a class="counters" href="{{ url('/panel/mieszkanie/'.$apartment -> id_apartment.'/liczniki') }}"><button><i class="far fa-chart-bar"></i> Wprowadź liczniki</button></a>
                @endif
                @if ($apartment -> user_id == Auth::id())
                    <a href="{{ url('/panel/mieszkanie/'.$apartment -> id_apartment.'/edycja') }}"><button class="settings-apartment"><i class="fas fa-cog"></i></button></a>
                @endif
            </section>
        </section>
        <a href="{{ url('/panel') }}"><button class="back"><i class="fas fa-chevron-left"></i> Wróć do panelu</button></a>
    </article>
    <script>
        const chart = new Chartisan({
            el: '#chart',
            url: 'http://planus.me/diagrams/sum_bill/' + {{$apartment -> id_apartment}},
            hooks: new ChartisanHooks()
                .legend(false)
                .beginAtZero()
                .minimalist()
                .colors(['#FFA500']),
        })
        const chart2 = new Chartisan({
            el: '#chart2',
            url: 'http://planus.me/diagrams/cold_water/' + {{$apartment -> id_apartment}},
            hooks: new ChartisanHooks()
                .legend(false)
                .beginAtZero()
                .minimalist()
                .colors(['#45D8E1']),
        })
        const chart3 = new Chartisan({
            el: '#chart3',
            url: 'http://planus.me/diagrams/hot_water/' + {{$apartment -> id_apartment}},
            hooks: new ChartisanHooks()
                .legend(false)
                .beginAtZero()
                .minimalist()
                .colors(['#FF0000']),
        })
        const chart4 = new Chartisan({
            el: '#chart4',
            url: 'http://planus.me/diagrams/gas/' + {{$apartment -> id_apartment}},
            hooks: new ChartisanHooks()
                .legend(false)
                .beginAtZero()
                .minimalist()
                .colors(['#56CA53']),
        })
        const chart5 = new Chartisan({
            el: '#chart5',
            url: 'http://planus.me/diagrams/electricity/' + {{$apartment -> id_apartment}},
            hooks: new ChartisanHooks()
                .legend(false)
                .beginAtZero()
                .minimalist()
                .colors(['#FFD600']),
        })
    </script>
@endsection
