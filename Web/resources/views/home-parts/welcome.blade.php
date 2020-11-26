<article class="welcome">
    <section class="welcome-text">
        <h1>Planus</h1>
        <h4>Dom jest tam, gdzie czujesz się jak w domu.</h4>
        @if (!Auth::user())
        <a href="{{ route('login') }}"><button>Dołącz do nas</button></a>
        @else
        <a href="{{ url('/panel') }}"><button>Zarządzaj</button></a>
        @endif
    </section>
    <i class="fas fa-arrow-circle-down"></i>
</article>
