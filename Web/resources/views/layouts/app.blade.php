<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <!-- Favicon -->
    <link rel="shortcut icon" href={{ asset("../favicon.ico")}} />
    <link rel="apple-touch-icon" sizes="256x256" href={{ asset("../favicon.ico") }} />
    <link rel="apple-touch-startup-image" href={{ asset("../favicon.ico") }} />

    <title>Planus - Wynajmij nowe mieszkanie</title>

    <!-- Scripts -->
    <script src="{{ asset('js/app.js') }}" defer></script>
    <script src="{{ asset('js/script.js') }}" defer></script>
    <script src="{{ asset('js/scroll.js') }}" defer></script>

    <!-- Font Awesome -->
    <script src="https://kit.fontawesome.com/95a2d2c3f2.js" crossorigin="anonymous"></script>

    <!-- JQuery -->
    <script src="https://code.jquery.com/jquery-3.3.1.js"></script>

    <!-- Fonts -->
    <link rel="dns-prefetch" href="//fonts.gstatic.com">

    <!-- Styles -->
    <link href="{{ mix('css/app.css') }}" rel="stylesheet">

    @if ($diagrams ?? '' == True)
    <!-- Charting library -->
    <script src="https://unpkg.com/chart.js@2.9.3/dist/Chart.min.js"></script>
    <!-- Chartisan -->
    <script src="https://unpkg.com/@chartisan/chartjs@^2.1.0/dist/chartisan_chartjs.umd.js"></script>
    @endif
</head>
<body>
    @include('components.navbar')
    @yield('content')
    @include('components.footer')
</body>
</html>
