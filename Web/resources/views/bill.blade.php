<?php
    $active = 'bill';
    $diagrams = True;
?>

@extends('layouts.app')
@section('content')
    <article class="bill">
        <section class="left-part">
            <div class="header">
                <h1>Rachunek za <span class="orange-text">miesszkanie</span></h1>
                <h1>Termin rozliczeniowy: {{ $apartment -> settlement_day }}.{{ date('m.y', strtotime($bill -> settlement_date)) }}</h1>
            </div>
            <div id="chart" style="width: 250px; height: 250px"></div>
        </section>
        <section class="center-part">
            <h3>Miesięczne <span class="orange-text">koszty</span></h3>
            <div id="chart2" style="width: 250px; height: 250px"></div>
            @if (Auth::id() == $apartment -> user_id)
            <h3>Dodaj <span class="orange-text">opłatę</span></h3>
            <form action="{{ url('/panel/mieszkanie/'.$apartment -> id_apartment.'/rachunki/'.$bill -> id_bill.'/dodaj_oplate') }}" method="POST">
                @csrf
                <span class="name">
                    <i class="fas fa-wallet"></i>
                    <input id="name" type="text" @error('name') is-invalid @enderror" name="name" value="{{ old('name') }}" required placeholder="Nazwa opłaty" minlength="5">
                </span>
                <span class="price">
                    <i class="fas fa-money-bill-alt"></i>
                    <input id="price" type="text" @error('price') is-invalid @enderror" name="price" value="{{ old('price') }}" required placeholder="Wysokość opłaty" minlength="5">
                </span>
                <button type="submit">Dodaj</button>
            </form>
            @endif
        </section>
        <section class="right-part">
            <img src="{{ asset('resources/img/svg/bills.svg') }}" alt="">
        </section>
        <a href="{{ url('/panel') }}"><button class="back"><i class="fas fa-chevron-left"></i> Wróć</button></a>
    </article>
    <script>
        @if ($counters > 3)
            const chart = new Chartisan({
                el: '#chart',
                url: 'http://planus.me/diagrams/sum_bill/' + {{$apartment -> id_apartment}},
                hooks: new ChartisanHooks()
                    .legend(false)
                    .beginAtZero()
                    .minimalist()
                    .colors(['#FFA500']),
            })
        @endif
        const chart2 = new Chartisan({
            el: '#chart2',
            url: 'http://planus.me/diagrams/cold_water/' + {{$apartment -> id_apartment}},
            hooks: new ChartisanHooks()
                .legend(false)
                .beginAtZero()
                .minimalist()
                .colors(['#45D8E1']),
        })
    </script>
@endsection
