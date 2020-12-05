@component('mail::message')
Cześć **{{$name}}**,  {{-- use double space for line break --}}
Dziękujemy za wybranie Planus!

Użyj poniższego przycisku, aby potwierdzić swój adres email.
@component('mail::button', ['url' => $link])
Potwierdź
@endcomponent
Z pozdrowieniami, Planus.
@endcomponent
