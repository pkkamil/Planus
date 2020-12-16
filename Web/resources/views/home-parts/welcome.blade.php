<article class="welcome">
    <section class="welcome-text">
        <h1>Planus</h1>
        <h4>Dom jest tam, gdzie czujesz się jak w domu.</h4>
        @if (!Auth::user())
            <a class="button" href="{{ route('login') }}">Dołącz do nas</a>
        @else
            <a class="button" href="{{ url('/panel') }}">Zarządzaj</a>
        @endif
    </section>
    <i class="fas fa-arrow-circle-down"></i>
</article>
