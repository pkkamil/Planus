<?php
    $active = 'all-bills';
    $diagrams = True;
?>

@extends('layouts.app')
@section('content')
    <article class="all-bills">
        <a class="button back" href="{{ url(str_replace('/rachunki', '', url()->current())) }}"><i class="fas fa-chevron-left"></i> Wróć</a>
        <h2>Twoje <span class="orange-text">rachunki</span></h2>
        <section class="list-of-bills">
            @foreach ($bills as $bill)
                <a class="single-bill" href="{{ url(url()->current().'/'.$bill -> id) }}">
                    <h3>{{ $bill -> sum }} zł</h3>
                    <h4>{{ $bill -> date }}</h4>
                </a>
            @endforeach
        </section>
    </article>
@endsection
