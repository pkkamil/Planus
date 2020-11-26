<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class Decided
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        if (count(Auth::user() -> residents) == 0 or count(Auth::user() -> apartments) == 0)
            return redirect('/decyzja');
        else
            return $next($request);
    }
}
