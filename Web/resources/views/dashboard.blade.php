<?php
    $active = 'dashboard';
    $diagrams = True;
    $title = 'Panel | Planus';
    $lazy = True;
?>

@extends('layouts.app')
@section('content')
    <article class="activity-center @if (count($apartments) == 1) single @endif">
        <section class="left-part">
            <h2>Witaj, <span class="orange-text">{{ Auth::user() -> name }}</span>! <i class="far fa-bell"></i></h2>
                <section class="list-apartments some">
                    @if (count($apartments) == 1)
                        <section class="single-apartment">
                            <a href="{{ url("panel/mieszkanie/".$apartments -> first() -> id_apartment) }}">
                                <img src="{{ $apartments -> first() -> image }}" alt="{{ $apartments -> first() -> name }}">
                                <h3>{{ $apartments -> first() -> name }}</h3>
                                <section class="layer">
                                    <h4>Więcej szczegółów</h4>
                                </section>
                            </a>
                        </section>
                    @else
                        @foreach($apartments as $apartment)
                            @if ($loop -> index < 2)
                                <section class="single-apartment smaller">
                                    <a href="{{ url("panel/mieszkanie/".$apartment -> id_apartment) }}">
                                        <img src="{{ $apartment -> image }}" alt="{{ $apartment -> name }}" class="lazy">
                                        <h3>{{ $apartment -> name }}</h3>
                                        <section class="layer">
                                            <h4>Więcej szczegółów</h4>
                                        </section>
                                    </a>
                                </section>
                            @endif
                        @endforeach
                    @endif
                </section>
                @if (count($apartments) > 2)
                    <a href="{{ route('showAll') }}"><button>Zobacz wszystkie</button></a>
                @endif
                @if (count($apartments) == 1)
                    <h3 class="members-header">Mieszkańcy</h3>
                    <section class="list-of-members">
                        @foreach ($apartments -> first() -> roommates as $member)
                            <div class="single-member">
                                @if (Auth::id() == $apartments -> first() -> user_id or $member -> id == Auth::id())
                                    <div class="circle" onclick="showDeleteCircle(this)">{{ $member -> name[0] }}</div>
                                    <div class="circle-delete" onclick="window.location = '/panel/mieszkanie/' + {{ $apartments -> first() -> id_apartment }}+'/usun_mieszkanca/'+{{ $member -> id }};"><i class="fas fa-times"></i></div>
                                @else
                                    <div class="circle">{{ $member -> name[0] }}</div>
                                @endif
                                <p>{{ $member -> name }}</p>
                            </div>
                        @endforeach
                        @if ($apartments -> first() -> user_id == Auth::id())
                            <div class="single-member">
                                <div class="circle-add" onclick="showModal()"><i class="fas fa-plus"></i></div>
                            </div>
                        @endif
                      </section>
                @else
                    <h4 class="events">Nadchodzące <span class="orange-text">zdarzenia</span></h3>
                    <ul class="list-of-events">
                        @if (count($soon) > 0)
                            @foreach ($soon as $el)
                                <li class="item-event">{!! $el !!},</li>
                            @endforeach
                        @else
                            <li class="item-event-empty">Nie masz żadnych zbliżających się zdarzeń</li>
                        @endif
                    </ul>
                @endif
        </section>
        @if (count($apartments) == 1)
            <section class="right-part">
                <h4>Miesięczne <span class="orange-text">koszty</span></h4>
                @if ($bills < 3)
                    <section class="statistics">
                        <h5>Brak statystyk do wyświetlenia.</h5>
                        <h6>Po 3 terminach rozliczeń zostaną one tutaj wyświetlone.</h6>
                    </section>
                @else
                <section class="single-chart">
                    <div id="chart"></div>
                </section>
                @endif
                <section class="bottom-part">
                    @if ($days > 1)
                        <p>Do terminu rozliczenia <br>pozostało <span class="orange-text">{{ $days }}</span>&nbsp;dni.</p>
                    @elseif ($days == 1)
                        <p>Do terminu rozliczenia <br>pozostał <span class="orange-text">{{ $days }}</span>&nbsp;dzień.</p>
                    @elseif ($days == -1)
                        <p><br><span class="orange-text">Dzisiaj</span> wypada termin rozliczenia.</p>
                    @else
                        <p><br><span class="orange-text">Jutro</span> wypada termin rozliczenia.</p>
                    @endif
                    <p>@if ($interval_to_end > 0)Pozostały okres rozliczeniowy:@endif<span class="orange-text">@if ($interval_to_end > 0) {{ $interval_to_end }} @endif @if ($interval_to_end > 1 and $interval_to_end < 4) miesiące @endif @if ($interval_to_end > 4) miesięcy @elseif ($interval_to_end == 1) miesiąc @elseif ($interval_to_end == 0)<span style="color: #555">Jest to <span class="orange-text">ostatni miesiąc</span> rozliczeniowy</span>@elseif ($interval_to_end < 0) <span style="color: #F00">Koniec okresu rozliczeniowego</span> @endif<span></p>
                </section>
                 @if ($apartments -> first() -> user_id == Auth::id() and $days < 2 or $apartments -> first() -> user_id == Auth::id() and $overdue)
                    <section class="buttons">
                        @if ($bills > 0)
                            <a class="bills button" href="{{ url('/panel/mieszkanie/'.$apartments -> first() -> id_apartment.'/rachunki') }}"><i class="fas fa-money-bill-alt"></i> Rachunki</a>
                        @endif
                        <a class="counters button" href="{{ url('/panel/mieszkanie/'.$apartments -> first() -> id_apartment.'/liczniki') }}"><i class="far fa-chart-bar"></i> Wprowadź liczniki</a>
                    </section>
                @endif
            </section>
        @else
            <section class="right-part svg">
                <img src="{{ asset('resources/img/svg/dashboard.svg') }}" alt="illustration">
            </section>
        @endif
        <a class="button settings" href="{{ url('/panel/ustawienia') }}"><i class="fas fa-cog"></i> Ustawienia konta</a>
    </article>
    @if (count($apartments) == 1)
        <article class="dimmer">
            <section class="modal add-members">
                <section class="top-part">
                    <section class="lp">
                        <h2>Dodaj <span class="orange-text">mieszkańców</span></h2>
                        <p>Aby dodać nowych mieszkańców, udostępnij swój <span class="orange-text">kod zaproszenia</span>.</p>
                        <p class="code">Kod zaproszenia: <span class="orange-text">{{ $apartments -> first() -> invite_code }}</span></p>
                    </section>
                    <section class="rp">
                        <p>Udostępnij swój <span class="orange-text">kod QR</span></p>
                        {!! QrCode::size(96)->generate($apartments -> first() -> invite_code); !!}
                    </section>
                </section>
                <form class="bp" method="POST" action="{{ url('/panel/mieszkanie/'.$apartments -> first() -> id_apartment.'/nowy_mieszkaniec') }}">
                    @csrf
                    <h2>Utwórz osobę <span class="orange-text">zamieszkującą</span></h2>
                    <span class="single-input">
                        <label for="name">Imie: </label>
                        <input type="text" name="name" id="name">
                    </span>
                    <button type="submit">Dodaj</button>
                </form>
                <button class="close" type="button" onclick="hideModal()">Wróć</button>
            </section>
        </article>
        <script>
            @if ($bills > 3)
                const chart = new Chartisan({
                    el: '#chart',
                    url: 'http://planus.me/diagrams/sum_bill/' + {{$apartments -> first() -> id_apartment}},
                    hooks: new ChartisanHooks()
                        .legend(false)
                        .beginAtZero()
                        .minimalist()
                        .colors(['#FFA500']),
                })
            @endif

            function showModal() {
                document.querySelector('.dimmer').style.display = 'flex'
            }

            function hideModal() {
                document.querySelector('.dimmer').style.display = 'none'
            }

            let allCircles = document.querySelectorAll('.circle-delete')

            allCircles.forEach(circle => {
                circle.addEventListener('click', () => {

                })
            })

            function showDeleteCircle(e) {
                if (e.nextElementSibling.style.display == 'flex') {
                    hideDeleteCircle(e.nextElementSibling)
                } else {
                    allCircles.forEach(circle => {
                        if (circle.style.display == 'flex')
                            hideDeleteCircle(circle)
                    })
                    e.nextElementSibling.style.display = 'flex'
                    $(e.nextElementSibling).animate({
                        top: -1/2*$(e.nextElementSibling).height()
                    }, 500)
                }
            }

            function hideDeleteCircle(e) {
                $(e).animate({
                    top: 0
                }, 500)
                setTimeout(() => {
                    e.style.display = 'none'
                }, 500)
            }
        </script>
    @endif
@endsection
