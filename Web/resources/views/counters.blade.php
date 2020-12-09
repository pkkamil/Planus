<?php
    $active = 'counters';
    $diagrams = True;
?>

@extends('layouts.app')
@section('content')
    <form class="enter-counters" action="{{ route('enterCounters') }}" method="POST" autocomplete="off">
        @csrf
        <input type="hidden" name="id_apartment" value="{{ $apartment -> id_apartment }}">
        <section class="left-part">
            <h3>Wprowadź <span class="orange-text">liczniki</span></h3>
            @if ($apartment -> cold_water)
            <span @error('cold_water') style="border-color: red" @enderror class="cold_water">
                <i class="fas fa-tint"></i>
                <input id="cold_water" type="text" @error('cold_water') is-invalid @enderror name="cold_water" value="{{ old('cold_water') }}" placeholder="Stan licznika wody zimnej [1m&sup3;]">
            </span>
            @endif
            @if ($apartment -> hot_water)
            <span @error('hot_water') style="border-color: red" @enderror class="hot_water">
                <i class="fas fa-water"></i>
                <input id="hot_water" type="text" @error('hot_water') is-invalid @enderror name="hot_water" value="{{ old('hot_water') }}" placeholder="Stan licznika wody ciepłej [1m&sup3;]">
            </span>
            @endif
            @if ($apartment -> gas)
            <span @error('gas') style="border-color: red" @enderror class="gas">
                <i class="fas fa-gas-pump"></i>
                <input id="gas" type="text" @error('gas') is-invalid @enderror name="gas" value="{{ old('gas') }}" placeholder="Stan licznika gazu [1kWh]">
            </span>
            @endif
            @if ($apartment -> electricity)
            <span @error('electricity') style="border-color: red" @enderror class="electricity">
                <i class="fas fa-bolt"></i>
                <input id="electricity" type="text" @error('electricity') is-invalid @enderror name="electricity" value="{{ old('electricity') }}" placeholder="Stan licznika prądu [1kWh]">
            </span>
            @endif
            <h4>Koszty <span class="orange-text">mediów</span></h4>
            @if ($apartment -> cold_water)
            <div class="single-media">
                <p>Zużyto <span class="orange-text cw">0</span> m&sup3; wody zimnej</p>
                <p>Koszt <span class="orange-text kcw">0</span> zł</p>
            </div>
            @endif
            @if ($apartment -> hot_water)
            <div class="single-media">
                <p>Zużyto <span class="orange-text hw">0</span> m&sup3; wody ciepłej</p>
                <p>Koszt <span class="orange-text khw">0</span> zł</p>
            </div>
            @endif
            @if ($apartment -> gas)
            <div class="single-media">
                <p>Zużyto <span class="orange-text g">0</span> kWh gazu</p>
                <p>Koszt <span class="orange-text kg">0</span> zł</p>
            </div>
            @endif
            @if ($apartment -> electricity)
            <div class="single-media">
                <p>Zużyto <span class="orange-text e">0</span> kWh prądu</p>
                <p>Koszt <span class="orange-text ke">0</span> zł</p>
            </div>
            @endif
        </section>
        <section class="right-part">
            @if ($bills > 2)
                <h4>Statystki zużycia <span class="orange-text">mediów</span></h4>
                <section class="diagrams">
                    @if ($apartment -> cold_water)
                        <section class="single-chart">
                            <div id="chart" style="width: 300px; height: 300px"></div>
                            <h6>Zużycie <span style="color: #45D8E1">wody zimnej</span></h6>
                        </section>
                    @endif
                    @if ($apartment -> hot_water)
                        <section class="single-chart">
                            <div id="chart2" style="width: 300px; height: 300px"></div>
                            <h6>Zużycie <span style="color: #FF0000">wody ciepłej</span></h6>
                        </section>
                    @endif
                    @if ($apartment -> gas)
                        <section class="single-chart">
                            <div id="chart3" style="width: 300px; height: 300px"></div>
                            <h6>Zużycie <span style="color: #56CA53">gazu</span></h6>
                        </section>
                    @endif
                    @if ($apartment -> electricity)
                        <section class="single-chart">
                            <div id="chart4" style="width: 300px; height: 300px"></div>
                            <h6>Zużycie <span style="color: #FFD600">prądu</span></h6>
                        </section>
                    @endif
                </section>
            @else
                <img src="{{ asset('resources/img/svg/counters.svg') }}" alt="">
            @endif
            <button type="submit">Zapisz liczniki</button>
        </section>
        <a href="{{ url()->previous() }}"><button type="button" class="back"><i class="fas fa-chevron-left"></i> Wróć</button></a>
    </form>
    <script>
        @if ($bills > 2)
            @if ($apartment -> cold_water)
                const chart = new Chartisan({
                    el: '#chart',
                    url: 'http://planus.me/chart/data/consumption/' + {!!$apartment -> id_apartment!!} + '/cold-water',
                    hooks: new ChartisanHooks()
                    .legend(false)
                    .beginAtZero()
                    .minimalist()
                    .colors(['#45D8E1'])
                })
            @endif
            @if ($apartment -> hot_water)
                const chart2 = new Chartisan({
                    el: '#chart2',
                    url: 'http://planus.me/chart/data/consumption/' + {!!$apartment -> id_apartment!!} + '/hot-water',
                    hooks: new ChartisanHooks()
                        .legend(false)
                        .beginAtZero()
                        .minimalist()
                        .colors(['#FF0000'])
                })
            @endif
            @if ($apartment -> gas)
                const chart3 = new Chartisan({
                    el: '#chart3',
                    url: 'http://planus.me/chart/data/consumption/' + {!!$apartment -> id_apartment!!} + '/gas',
                    hooks: new ChartisanHooks()
                        .legend(false)
                        .beginAtZero()
                        .minimalist()
                        .colors(['#56CA53']),
                })
            @endif
            @if ($apartment -> electricity)
                const chart4 = new Chartisan({
                    el: '#chart4',
                    url: 'http://planus.me/chart/data/consumption/' + {!!$apartment -> id_apartment!!} + '/electricity',
                    hooks: new ChartisanHooks()
                        .legend(false)
                        .beginAtZero()
                        .minimalist()
                        .colors(['#FFD600']),
                })
            @endif
        @endif
        let cC = parseFloat({!! $apartment -> cold_water !!})
        let cH = parseFloat({!! $apartment -> hot_water !!})
        let cG = parseFloat({!! $apartment -> gas !!})
        let cE = parseFloat({!! $apartment -> electricity !!})
        let counters = {!!$lastCounter!!}
        let inputs = document.querySelectorAll('input')
        let cold_water, hot_water, gas, electricity = 0
        inputs.forEach(input => {
            input.addEventListener('change', (e) => {
                let value = parseFloat(e.target.value)
                if (e.target.id == 'cold_water') {
                    cold_water = (value - parseFloat(counters['cold_water'])).toFixed(2)
                    document.querySelector('.single-media .cw').textContent = cold_water
                    document.querySelector('.single-media .kcw').textContent = (cold_water*cC).toFixed(2)
                } else if (e.target.id == 'hot_water') {
                    hot_water = (value - parseFloat(counters['hot_water'])).toFixed(2)
                    document.querySelector('.single-media .hw').textContent = hot_water
                    document.querySelector('.single-media .khw').textContent = (hot_water*cH).toFixed(2)
                } else if (e.target.id == 'gas') {
                    gas = (value - parseFloat(counters['gas'])).toFixed(2)
                    document.querySelector('.single-media .g').textContent = gas
                    document.querySelector('.single-media .kg').textContent = (gas*cG).toFixed(2)
                } else {
                    electricity = (value - parseFloat(counters['electricity'])).toFixed(2)
                    document.querySelector('.single-media .e').textContent = electricity
                    document.querySelector('.single-media .ke').textContent = (electricity*cE).toFixed(2)
                }
                let allValues = [cold_water, hot_water, gas, electricity]
                for (let i = 0; i < allValues.length; i++) {
                    if (allValues[i] < 0) {
                        document.querySelector('button[type="submit"]').disabled = true
                        document.querySelector('button[type="submit"]').classList.add('disabled')
                        break
                    }
                    if (allValues[i] > 0 && document.querySelector('button[type="submit"]').disabled) {
                        console.log('nie wal sie')
                        document.querySelector('button[type="submit"]').disabled = false
                        document.querySelector('button[type="submit"]').classList.remove('disabled')
                    }
                }
            })
        })
    </script>
@endsection
