let arrow = document.querySelector('i.fa-arrow-circle-down')

arrow.addEventListener('click', () => {
    window.scrollTo(0, document.querySelector('.apartments').offsetTop - $('nav').height())
})

document.addEventListener('scroll', () => {
    if (window.scrollY > 50)
        document.querySelector('nav').classList.add('orange')
    else
        document.querySelector('nav').classList.remove('orange')
})

document.addEventListener('DOMContentLoaded', () => {
    if (window.scrollY > 50) {
        document.querySelector('nav').classList.add('orange')
    }
})

$(".smooth-scroller").click(function() {
    if (window.innerWidth > 976) {
        window.scrollTo(0, document.querySelector($(this).data('scroll')).offsetTop - $('nav').height())
        console.log($('nav').height())
        console.log(document.querySelector($(this).data('scroll')).offsetTop - $('nav').height())
    } else {
        $("nav ul").removeClass("showing")
        $([document.documentElement, document.body]).animate({
                scrollTop: $($(this).data("scroll")).offset().top - 180,
            },
            2000
        )
    }
})