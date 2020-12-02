<?php
    $active = 'counters';
?>

@extends('layouts.app')
@section('content')
    <form class="enter-counters" action="{{ route('enterCounters') }}" method="POST" autocomplete="off">
        @csrf
        <section class="left-part">
            <h3>Wprowadź <span class="orange-text">liczniki</span></h3>
            @if ($apartment -> cold_water)
            <span class="cold_water">
                <i class="fas fa-tint"></i>
                <input id="cold_water" type="text" @error('cold_water') is-invalid @enderror" name="cold_water" value="{{ old('cold_water') }}" placeholder="Ilość zużytej wody zimnej [1m&sup3;]">
            </span>
            @endif
            @if ($apartment -> hot_water)
            <span class="hot_water">
                <i class="fas fa-water"></i>
                <input id="hot_water" type="text" @error('hot_water') is-invalid @enderror" name="hot_water" value="{{ old('hot_water') }}" placeholder="Ilość zużytej wody ciepłej [1m&sup3;]">
            </span>
            @endif
            @if ($apartment -> gas)
            <span class="gas">
                <i class="fas fa-gas-pump"></i>
                <input id="gas" type="text" @error('gas') is-invalid @enderror" name="gas" value="{{ old('gas') }}" placeholder="Ilość zużytego wody gazu [1kWh]">
            </span>
            @endif
            @if ($apartment -> electricity)
            <span class="electricity">
                <i class="fas fa-bolt"></i>
                <input id="electricity" type="text" @error('electricity') is-invalid @enderror" name="electricity" value="{{ old('electricity') }}" placeholder="Ilość zużytego prądu [1kWh]">
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
                <p>Zużyto <span class="orange-text ch">0</span> m&sup3; wody ciepłej</p>
                <p>Koszt <span class="orange-text kch">0</span> zł</p>
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

        </section>
        <a href="{{ url('/panel') }}"><button class="back"><i class="fas fa-chevron-left"></i> Wróć do panelu</button></a>
    </form>
@endsection
