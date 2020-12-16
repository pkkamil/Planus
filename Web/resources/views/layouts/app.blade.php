<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-2SC2V93XM8"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'G-2SC2V93XM8');
    </script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0" />
    <meta name="description" content="Witryna internetowa ułatwiająca wynajmowanie mieszkań, a także zarządzanie rachunkami, zużyciem oraz kosztem mediów. Stwórz mieszkanie, wynajmij je i w łatwy sposób zarządzaj nim!" />
    <meta name="keywords" content="Planus, wynajem, wynajmowanie, mieszkania, rachunki, zużycie mediów, wynajmowanie mieszkań, wynajem mieszkań, dom jest tam, gdzie czujesz się jak w domu, dom, mieszkanie, mieszkać, żyć, przyjazne zakątki, aplikacja Planus, strona internetowa Planus, witryna internetowa Planus, wynajmij mieszkanie, wynajmij, zarządzanie mieszkaniami, zarządzanie mieszkaniem, zarządzanie rachunkami, tworzenie mieszkania, dodawanie mieszkania" />
    <meta name="apple-mobile-web-app-title" content="Planus"/>
    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <!-- Favicon -->
    <link rel="shortcut icon" href={{ asset("../favicon.ico")}} />
    <link rel="apple-touch-icon" sizes="256x256" href={{ asset("../favicon.ico") }} />
    <link rel="apple-touch-startup-image" href={{ asset("../favicon.ico") }} />

    <!-- Open Graph -->
    <meta property="og:title" content="Planus - Wynajmuj i zarządzaj mieszkaniami" />
    <meta property="og:description" content="Witryna internetowa ułatwiająca wynajmowanie mieszkań, a także zarządzanie rachunkami, zużyciem oraz kosztem mediów. Stwórz mieszkanie, wynajmij je i w łatwy sposób zarządzaj nim!" />
    <meta property="og:type" content="website" />
    <meta property="og:image" content={{ asset("../favicon.ico") }} />
    <meta property="og:url" content="http://planus.me" />
    <meta property="og:site_name" content="Planus" />

    <title>{{ $title ?? 'Planus - Wynajmuj i zarządzaj mieszkaniami'}}</title>

    <!-- Canonical link -->
    <link rel="canonical" href="http://planus.me" />

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
        <!-- Lazy Loading -->
    @endif
    {{-- <style>
        .lazy {
            background-color: #FFA500;
        }
    </style>
    @if ($lazy ?? '' == True)
        <script defer src="https://cdnjs.cloudflare.com/ajax/libs/jquery.lazyload/1.9.1/jquery.lazyload.min.js" integrity="sha512-jNDtFf7qgU0eH/+Z42FG4fw3w7DM/9zbgNPe3wfJlCylVDTT3IgKW5r92Vy9IHa6U50vyMz5gRByIu4YIXFtaQ==" crossorigin="anonymous"></script>
        <script defer>
            $(document).ready(() => {
                $('.lazy').lazyload()
            })
        </script>
    @endif --}}
</head>
<body>
    @include('components.navbar')
    @yield('content')
    @include('components.footer')
    @if ($lazy ?? '' == True)
        <div class="loader-wrapper">
            <span class="loader"><span class="loader-inner"></span></span>
        </div>
        <script>
            $(window).on("load",function(){
              $(".loader-wrapper").fadeOut('slow');
            });
        </script>
    @endif
</body>
</html>
