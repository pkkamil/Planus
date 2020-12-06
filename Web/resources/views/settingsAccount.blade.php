<?php
    $active = 'account-settings';
?>

@extends('layouts.app')
@section('content')
    <article class="settings-account">
        <section class="left-part">
            <form action="{{ route('changeName') }}" method="POST">
                @csrf
                <h1>Witaj, <input type="text" id="name" name="name" value="{{ Auth::user() -> name }}" onchange="submit()">!</h1>
            </form>
            <h3>Twój obecny adres email to <span class="orange-text">{{ Auth::user() -> email }}</span></h3>
            <h2>Zmiana twojego <span class="orange-tex">adresu email</span></h2>
            <form action="{{ route('changeEmail') }}" method="POST">
                @csrf
                <span class="single-input">
                    <label for="email">Nowy adres email</label>
                    <input type="email" name="email" id="email">
                </span>
                <button type="submit">Zmień adres email</button>
            </form>
            <h2>Zmiana twojego <span class="orange-tex">hasła</span></h2>
            <form action="{{ route('changePassword') }}" method="POST">
                @csrf
                <span class="single-input">
                    <label for="current_password">Obecne hasło</label>
                    <input type="password" name="current_password" id="current_password">
                </span>
                <span class="single-input">
                    <label for="current_password">Nowe hasło</label>
                    <input type="password" name="new_password" id="new_password">
                </span>
                <span class="single-input">
                    <label for="current_password">Potwierdzenie hasła</label>
                    <input type="password" name="confirm_password" id="confirm_password">
                </span>
                <button type="submit">Zmień hasło</button>
            </form>
            @if ($errors->any())
                <div class="errors">
                    <ul>
                        @foreach ($errors->all() as $error)
                            <li>{{ str_replace('new password', 'Nowe hasło',$error) }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif
            @if(Session::has('message'))
                <p style="color: #1b551b; margin-top: 15px">Twoje hasło zostało zmienione.</p>
            @endif
        </section>
        <section class="right-part">
            <img src="{{ asset('resources/img/svg/settings.svg') }}" alt="">
            <button class="delete_account danger" onclick="showModal()"><i class="fas fa-trash-alt"></i> Usuń konto</button>
        </section>
        <a href="{{ url('/panel') }}"><button class="back"><i class="fas fa-chevron-left"></i> Wróć do panelu</button></a>
    </article>
    <article class="dimmer">
        <section class="modal">
            <h2>Czy jesteś pewien?</h2>
            <h4 style="color: #F00">Tego działania nie można cofnąć!</h4>
            <a href="{{ url('/panel/ustawienia/usun_konto') }}"><button class="danger">Usuń</button></a>
            <button onclick="hideModal()">Zrezygnuj</button>
        </section>
    </article>
    <script>

        function showModal() {
            document.querySelector('.dimmer').style.display = 'flex'
        }

        function hideModal() {
            document.querySelector('.dimmer').style.display = 'none'
        }
    </script>
@endsection
