<?php
    $active = 'counters';
?>

@extends('layouts.app')
@section('content')
    <form class="enter-counters" action="{{ route('initialCounters') }}" method="POST" autocomplete="off">
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
        </section>
        <section class="right-part">
            <img src="{{ asset('resources/img/svg/counters.svg') }}" alt="">
            <button type="submit">Zapisz liczniki</button>
        </section>
        <a href="{{ url('/panel') }}"><button type="button" class="back"><i class="fas fa-chevron-left"></i> Wróć do panelu</button></a>
    </form>
    <script>
        let inputs = document.querySelectorAll('input')
        let cold_water, hot_water, gas, electricity = 0
        inputs.forEach(input => {
            input.addEventListener('change', (e) => {
                let value = parseFloat(e.target.value)
                if (value < 0 || isNaN(value)) {
                        document.querySelector('button[type="submit"]').disabled = true
                        document.querySelector('button[type="submit"]').classList.add('disabled')
                } else if (value > 0 && !isNaN(value) && document.querySelector('button[type="submit"]').disabled) {
                        document.querySelector('button[type="submit"]').disabled = false
                        document.querySelector('button[type="submit"]').classList.remove('disabled')
                 }
            })
        })
    </script>
@endsection