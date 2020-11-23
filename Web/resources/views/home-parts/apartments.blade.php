<article class="apartments" id="apartments">
        <h2>Mieszkania</h2>
        <h4>Przejrzyj dostępne, przyjazne zakątki</h4>
        <section class="list-apartments">
            @foreach ($apartments as $apartment)
                @if ($loop -> index < 10)
                    <section class="single-apartment">
                        <img src="{{ $apartment -> image }}" alt="">
                        <section class="layer">
                            <h3>{{ $apartment -> price }} zł</h3>
                            <h4>{{ $apartment -> name }}</h4>
                            <h5>{{ $apartment -> localization }}</h5>
                        </section>
                    </section>
                @endif
            @endforeach
        </section>
        @if (count($apartments) > 10)
            <button>Zobacz więcej</button>
        @endif
</article>
