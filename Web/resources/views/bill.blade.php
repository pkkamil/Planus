<?php
    $active = 'bill';
    $diagrams = True;
?>

@extends('layouts.app')
@section('content')
    <article class="bill">
        <section class="left-part">
            <a class="button back" href="{{ url('/panel/mieszkanie/'.$bill -> id_apartment.'/rachunki') }}"><i class="fas fa-chevron-left"></i> Wróć</a>
            <div class="header">
                <h1>Rachunek za <span class="orange-text">mieszkanie</span></h1>
                <h6>Termin rozliczeniowy: {{ $apartment -> settlement_day }}.{{ date('m.Y', strtotime($bill -> settlement_date)) }}</h1>
            </div>
            <div id="chart"></div>
            <h4>Łączna<span class="orange-text"> kwota rachunku</span>: {{ $bill -> sum }}<span style="color: #999">&nbsp;zł</span></h4>
        </section>
        <section class="right-part">
            @if ($counters > 3)
                <h3>Statystyki <span class="orange-text">zużycia mediów</span></h3>
                <section class="statistics">
                    @if ($bill -> cold_water)
                        <div id="chart2"></div>
                    @endif
                    @if ($bill -> hot_water)
                        <div id="chart3"></div>
                    @endif
                    @if ($bill -> gas)
                        <div id="chart4"></div>
                    @endif
                    @if ($bill -> electricity)
                        <div id="chart5"></div>
                    @endif
                </section>
            @endif
            <section class="bottom-part">
                @if (Auth::id() == $apartment -> user_id)
                    <h3>Dodaj <span class="orange-text">dodatkową opłatę</span></h3>
                    <form action="{{ url('/panel/rachunki/dodaj_oplate') }}" method="POST">
                        @csrf
                        <input type="hidden" name="id_bill" value="{{ $bill -> id_bill }}">
                        <span class="name">
                            <i class="fas fa-wallet"></i>
                            <input id="name" type="text" @error('name') is-invalid @enderror" name="name" value="{{ old('name') }}" required placeholder="Nazwa opłaty" minlength="3">
                        </span>
                        <span class="price">
                            <i class="fas fa-money-bill-alt"></i>
                            <input id="price" type="text" @error('price') is-invalid @enderror" name="price" value="{{ old('price') }}" required placeholder="Wysokość opłaty" min="0">
                        </span>
                        <button type="submit">Dodaj</button>
                    </form>
                @else
                    <img src="{{ asset('resources/img/svg/payment.svg') }}" alt="">
                @endif
            </section>
        </section>
    </article>
    <script>
        const chart = new Chartisan({
            el: '#chart',
            url: 'http://planus.me/charts/single-bill/' + {{$bill -> id_bill}},
            hooks: new ChartisanHooks()
                .legend({ position: 'bottom' })
                .datasets('doughnut')
                .pieColors(),
        })
        @if ($counters > 3)
            @if ($bill -> cold_water)
            const chart2 = new Chartisan({
                el: '#chart2',
                url: 'http://planus.me/charts/current-consumption/' + {{$apartment -> id_apartment}} + '/cold-water/' + {{ $bill -> id_bill }},
                hooks: new ChartisanHooks()
                    .legend(false)
                    .beginAtZero()
                    .minimalist()
                    .colors(['#45D8E1']),
            })
            @endif
            @if ($bill -> hot_water)
            const chart3 = new Chartisan({
                el: '#chart3',
                url: 'http://planus.me/charts/current-consumption/' + {{$apartment -> id_apartment}} + '/hot-water/' + {{ $bill -> id_bill }},
                hooks: new ChartisanHooks()
                    .legend(false)
                    .beginAtZero()
                    .minimalist()
                    .colors(['#FF0000']),
            })
            @endif
            @if ($bill -> gas)
            const chart4 = new Chartisan({
                el: '#chart4',
                url: 'http://planus.me/charts/current-consumption/' + {{$apartment -> id_apartment}} + '/gas/' + {{ $bill -> id_bill }},
                hooks: new ChartisanHooks()
                    .legend(false)
                    .beginAtZero()
                    .minimalist()
                    .colors(['#56CA53']),
            })
            @endif
            @if ($bill -> electricity)
            const chart5 = new Chartisan({
                el: '#chart5',
                url: 'http://planus.me/charts/current-consumption/' + {{$apartment -> id_apartment}} + '/electricity/' + {{ $bill -> id_bill }},
                hooks: new ChartisanHooks()
                    .legend(false)
                    .beginAtZero()
                    .minimalist()
                    .colors(['#FFD600']),
            })
            @endif
        @endif
    </script>
@endsection
