<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Auth;

class ActivationMail extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->from('modern.creators.soul@gmail.com', 'Planus')
            ->subject('Potwierdzenie adresu email')
            ->markdown('mails.example')
            ->with([
                'name' => Auth::user() -> name ?? 'przyjacielu',
                'link' => 'http://www.planus.me'
            ]);
    }
}
