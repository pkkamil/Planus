<?php
    $active = 'chart';
    $diagrams = True;
?>

@extends('layouts.app')
@section('content')
<article style="width: 100%; height: 90vh; display: flex;justify-content:center;align-items:center;">
    <div id="chart" style="height: 300px;"></div>
    <div id="chart2" style="height: 280px;"></div>
    <div id="chart3" style="height: 280px;"></div>
    {{-- <div id="chart4" style="height: 280px;"></div> --}}
</article>
<script>
    const chart = new Chartisan({
        el: '#chart',
        url: 'http://planus.me/test/1',
        hooks: new ChartisanHooks()
            .legend({ position: 'bottom' })
            .datasets('doughnut')
            .pieColors(),
    })

    const chart2 = new Chartisan({
        el: '#chart2',
        url: 'http://planus.me/test/2/all',
        hooks: new ChartisanHooks()
            .legend(false)
            .beginAtZero()
            .colors(['#45D8E1'])
            // .datasets([{ type: 'line', fill: true }, 'bar'])
    })

    const chart3 = new Chartisan({
        el: '#chart3',
        url: 'http://planus.me/test/4',
        hooks: new ChartisanHooks()
            .legend(false)
            .beginAtZero()
            .colors(['#FFA500']),
    })
</script>
@endsection
