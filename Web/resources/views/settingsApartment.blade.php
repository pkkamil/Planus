<?php
    $active = 'apartment-settings';
    $title = 'Ustawienia mieszkania | Planus';
?>

@extends('layouts.app')
@section('content')
<form class="add-apartment edit-apartment" action="{{ route('edit') }}" method="POST" autocomplete="off" enctype="multipart/form-data">
    @csrf
    <input type="hidden" name="id_apartment" value="{{ $apartment -> id_apartment }}">
    <section class="left-part">
        <h2>Edytuj <span class="orange-text">mieszkanie</span></h2>
            <div class="image">
                <label for="image" style="background-image: url({{ $apartment -> image }})" @error('image') style="border: 1px solid #F00" @enderror><i class="fas fa-image" style="display: none"></i></label>
                <input id="image" type="file" @error('image') is-invalid @enderror" name="image" onchange="changeImageStatus()">
            </div>
            <span class="name">
                <i class="fas fa-home"></i>
                <input id="name" type="text" @error('name') is-invalid @enderror" name="name" value="{{ $apartment -> name }}" required placeholder="Nazwa mieszkania" minlength="5">
            </span>
            <span class="localization">
                <i class="fas fa-map-marker-alt"></i>
                <input id="localization" type="text" @error('localization') is-invalid @enderror" name="localization" value="{{ $apartment -> localization }}" required placeholder="Lokalizacja" minlength="5">
            </span>
            <span class="price">
                <i class="fas fa-money-bill-alt"></i>
                <input id="price" type="text" @error('price') is-invalid @enderror" name="price" value="{{ $apartment -> price }}" required placeholder="Cena wynajmu [zł]">
            </span>
            <span class="area">
                <i class="fas fa-expand-alt"></i>
                <input id="area" type="text" @error('area') is-invalid @enderror" name="area" value="{{ $apartment -> area }}" required placeholder="Powierzchnia [m&sup2;]">
            </span>
            <span class="rooms">
                <i class="fas fa-bed"></i>
                <input id="rooms" type="text" @error('rooms') is-invalid @enderror" name="rooms" value="{{ $apartment -> rooms }}" required placeholder="Liczba pokoi">
            </span>
            <span class="settlement_day">
                <i class="fas fa-calendar-day"></i>
                <input id="settlement_day" type="text" @error('settlement_day') is-invalid @enderror" name="settlement_day" value="{{ $apartment -> settlement_day }}" required placeholder="Dzień rozliczenia">
            </span>
            <span class="billing_period">
                <i class="fas fa-calendar-alt"></i>
                <input id="billing_period" type="text" @error('billing_period') is-invalid @enderror" name="billing_period" value="{{ $apartment -> billing_period }}" required placeholder="Okres rozliczenia [miesiące]">
            </span>
    </section>
    <section class="center-part">
        <h3>Opłaty za <span class="orange-text">media</span></h3>
        <span class="cold_water">
            <i class="fas fa-tint"></i>
            <input id="cold_water" type="text" @error('cold_water') is-invalid @enderror" name="cold_water" value="{{ $apartment -> cold_water }}" placeholder="Cena za 1m&sup3; wody zimnej">
            <input type="checkbox" name="cold_water_active" @if ($apartment -> cold_water) checked @endif>
            <i class="far fa-check-circle checkbox"></i>
        </span>
        <span class="hot_water">
            <i class="fas fa-water"></i>
            <input id="hot_water" type="text" @error('hot_water') is-invalid @enderror" name="hot_water" value="{{ $apartment -> hot_water }}" placeholder="Cena za 1m&sup3; wody ciepłej">
            <input type="checkbox" name="hot_water_active" @if ($apartment -> hot_water) checked @endif>
            <i class="far fa-check-circle checkbox"></i>
        </span>
        <span class="gas">
            <i class="fas fa-gas-pump"></i>
            <input id="gas" type="text" @error('gas') is-invalid @enderror" name="gas" value="{{ $apartment -> gas }}" placeholder="Cena za 1kWh gazu">
            <input type="checkbox" name="gas_active" @if ($apartment -> gas) checked @endif>
            <i class="far fa-check-circle checkbox"></i>
        </span>
        <span class="electricity">
            <i class="fas fa-bolt"></i>
            <input id="electricity" type="text" @error('electricity') is-invalid @enderror" name="electricity" value="{{ $apartment -> electricity }}" placeholder="Cena za 1kWh prądu">
            <input type="checkbox" name="electricity_active" @if ($apartment -> electricity) checked @endif>
            <i class="far fa-check-circle checkbox"></i>
        </span>
        <span class="rubbish">
            <i class="fas fa-trash"></i>
            <input id="rubbish" type="text" @error('rubbish') is-invalid @enderror" name="rubbish" value="{{ $apartment -> rubbish }}" placeholder="Cena za śmieci/os">
            <input type="checkbox" name="rubbish_active" @if ($apartment -> rubbish) checked @endif>
            <i class="far fa-check-circle checkbox"></i>
        </span>
        <span class="internet">
            <i class="fas fa-wifi"></i>
            <input id="internet" type="text" @error('internet') is-invalid @enderror" name="internet" value="{{ $apartment -> internet }}" placeholder="Cena za internet">
            <input type="checkbox" name="internet_active" @if ($apartment -> internet) checked @endif>
            <i class="far fa-check-circle checkbox"></i>
        </span>
        <span class="tv">
            <i class="fas fa-tv"></i>
            <input id="tv" type="text" @error('tv') is-invalid @enderror" name="tv" value="{{ $apartment -> tv }}" placeholder="Cena za telewizję">
            <input type="checkbox" name="tv_active" @if ($apartment -> tv) checked @endif>
            <i class="far fa-check-circle checkbox"></i>
        </span>
        <span class="phone">
            <i class="fas fa-phone-square-alt"></i>
            <input id="phone" type="text" @error('phone') is-invalid @enderror" name="phone" value="{{ $apartment -> phone }}" placeholder="Cena za telefon">
            <input type="checkbox" name="phone_active" @if ($apartment -> phone) checked @endif>
            <i class="far fa-check-circle checkbox"></i>
        </span>
    </section>
    <section class="right-part">
        <img src="{{ asset('resources/img/svg/add.svg') }}" alt="">
        <div class="public-checkbox">
            <label for="public">Publiczne <span class="orange-text">mieszkanie</span>:</label>
            <input type="checkbox" name="public" @if ($apartment -> public) checked @endif>
            <i class="far fa-check-circle checkbox"></i>
        </div>
        <button type="submit">Zapisz zmiany</button>
        @if ($errors->any())
            <div class="errors">
                <ul>
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif
        <button type="button" class="delete_apartment" onclick="showModal()"><i class="fas fa-trash-alt"></i> Usuń mieszkanie</button>
    </section>
    <a class="button back" href="{{ url()->previous() }}"><i class="fas fa-chevron-left"></i></a>
    <article class="dimmer">
        <section class="modal">
            <img src="{{ asset('resources/img/svg/delete.svg') }}" alt="">
            <h2>Próbujesz usunąć swoje <span class="orange-text">mieszkanie</span>.</h2>
            <h4>Czy jesteś pewny?</h4>
            <a href="{{ url('/panel/mieszkanie/'.$apartment -> id_apartment.'/usun_mieszkanie') }}"><button type="button" class="danger">Usuń</button></a>
            <button type="button" onclick="hideModal()">Zrezygnuj</button>
        </section>
    </article>
</form>

<script>
function changeImageStatus() {
    document.querySelector('.image label').style.background = 'transparent'
    document.querySelector('.image label').style.border = '4px solid #FFA500'
    document.querySelector('.image label i').style.display = 'block'
    document.querySelector('.image label i').style.color = '#FFA500'
}

function changeCheckboxStatus(e) {
    let el = e.path[1].querySelector('input[type="checkbox"]')
    if (el.checked) {
        e.target.classList.remove('fas')
        e.target.classList.add('far')
        el.checked = false
    } else {
        e.target.classList.remove('far')
        e.target.classList.add('fas')
        el.checked = true
    }
}

document.addEventListener('DOMContentLoaded', () => {
    ch = document.querySelectorAll('input[type="checkbox"]:not(#nav)')
    ch.forEach(single => {
        if (single.checked) {
            single.nextElementSibling.classList.remove('far')
            single.nextElementSibling.classList.add('fas')
        }
    })
})

const checkboxes = document.querySelectorAll('.checkbox')
checkboxes.forEach(checkbox => {
    checkbox.addEventListener('click', changeCheckboxStatus)
})

    function showModal() {
        document.querySelector('.dimmer').style.display = 'flex'
    }

    function hideModal() {
        document.querySelector('.dimmer').style.display = 'none'
    }
</script>
@endsection
