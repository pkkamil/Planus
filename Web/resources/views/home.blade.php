<?php
    $scrollTo = 'apartments';
    $active = '';
    $headerClass = 'home';
?>

@extends('layouts.app')
@section('content')
@include('home-parts.welcome')
@include('home-parts.apartments')
<article class="divider"></article>
@include('home-parts.our-app')
@endsection
