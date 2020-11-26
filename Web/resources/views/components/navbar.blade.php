<nav>
    <input type='checkbox' id="nav" class="hidden">
    <label for="nav" class="nav-btn">
        <i></i>
        <i></i>
        <i></i>
    </label>
    <div class="logo">
        <a href="/#">Planus</a>
    </div>
    <div class="nav-wrapper">
        <ul>
            @guest
                <li><a class="smooth-scroller" data-scroll="#apartments" href="{{ url('/#apartments') }}">Mieszkania</a></li>
                <li><a class="smooth-scroller" data-scroll="#our-app" href="/#our-app">Nasza aplikacja</a></li>
                @if ($active == 'register')
                    <li><a @if ($active =='register' ) class="active" @endif href="{{ route('register') }}">Rejestracja</a></li>
                @else
                    <li><a @if ($active =='login' ) class="active" @endif href="{{ route('login') }}">Logowanie</a></li>
                @endif
            @else
                <li><a @if ($active  == 'dashboard') class="active" @endif href="/panel">Panel</a></li>
                {{-- <li><a class="smooth-scroller" data-scroll="#apartments" href="#apartments">Mieszkania</a> --}}
                <li><a @if ($active  == 'rent') class="active" @endif href="{{ route('rentApartment') }}">Wynajmij mieszkanie</a></li>
                <li><a @if ($active  == 'add') class="active" @endif href="{{ route('addApartment') }}">Dodaj mieszkanie</a></li>
                <li>
                    <a href="{{ route('logout') }}" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">{{ __('Wyloguj') }}</a>
                    <form id="logout-form" action="{{ route('logout') }}" method="POST">
                        @csrf
                    </form>
                </li>
            @endguest
            </ul>
        </div>
    </nav>
