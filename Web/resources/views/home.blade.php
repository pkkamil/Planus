<?php
    $scrollTo = 'apartments';
    $active = '';
    $headerClass = 'home';
    $title = 'Planus - Wynajmuj i zarządzaj mieszkaniami';
    $lazy = True;
?>

@extends('layouts.app')
@section('content')
@include('home-parts.welcome')
@include('home-parts.apartments')
<article class="divider"></article>
@include('home-parts.our-app')
@endsection
