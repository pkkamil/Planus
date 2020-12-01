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
</article>
<script>
    const chart = new Chartisan({
        el: '#chart',
        url: 'http://planus.me/test/1',
        hooks: new ChartisanHooks()
            .legend({ position: 'bottom' })
            .title('Miesięczne koszty')
            .datasets('doughnut')
            .pieColors(),
    })

    const chart2 = new Chartisan({
        el: '#chart2',
        url: 'http://planus.me/test/2',
        hooks: new ChartisanHooks()
            .legend(false)
            .beginAtZero()
            .colors(['#FFA500']),
    })

    const chart3 = new Chartisan({
        el: '#chart3',
        url: 'http://planus.me/test/3',
        hooks: new ChartisanHooks()
            .legend(false)
            .beginAtZero()
            .colors(['#FFA500']),
    })
</script>
@endsection
