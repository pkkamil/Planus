<?php
    $scrollTo = '';
    $active = '';
    $headerClass = 'apartment';
?>

@extends('layouts.app')
@section('content')
    <article class="apartment">
        <section class="left-part">
            <h2>{{ $apartment -> name }}</h2>
            <h4>{{ $apartment -> localization }}</h4>
            <h3>Powierzchnia: {{ $apartment -> area }}&nbsp;m<sup>2</sup></h3>
            <h3>Liczba pokoi: {{ $apartment -> rooms }}</h3>

            <section class="down-part">
                <h3>Miesięczny koszt wynajmu: {{ $apartment -> price }}&nbsp;<span style="color: #999">zł</span></h3>
                <h6>+ opłata za media</h6>
                <button onClick="showModal()">Wynajmij</button>
            </section>
        </section>
        <section class="right-part">
            <img src="{{ $apartment -> image }}" alt="">
        </section>
    </article>
    <article class="dimmer">
        <section class="modal">
            <img style="width: 30%" src="{{ asset('resources/img/svg/modal-rent.svg') }}" alt="">
            <h2>Czy jesteś pewien?</h2>
            <h4>Właściciel mieszkania zostanie o tym poinformowany, po czym skontaktuje się z tobą.</h4>
            <a href="{{ route('informOwner') }}"><button>Wynajmij</button></a>
            <button onclick="hideModal()">Zrezygnuj</button>
        </section>
    </article>
<script>
    function showModal() {
        document.querySelector('.dimmer').style.display = 'flex'
    }

    function hideModal() {
        document.querySelector('.dimmer').style.display = 'none'
    }
</script>
@endsection
