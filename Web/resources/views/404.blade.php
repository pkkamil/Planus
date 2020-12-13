<?php
    $active = '';
    $title = 'Nie znaleziono | Planus';
?>

@extends('layouts.app')
@section('content')
    <article class="not-found">
        <img src="{{ asset('resources/img/svg/404.svg') }}" alt="">
        <h2>Strona, której szukasz nie istnieje.</h2>
    </article>
@endsection
