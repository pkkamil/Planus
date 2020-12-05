let arrow = document.querySelector('i.fa-arrow-circle-down')

if (arrow != null) {
    arrow.addEventListener('click', () => {
        window.scrollTo(0, document.querySelector('.apartments').offsetTop - $('nav').height())
    })

    let navItems = document.querySelectorAll('.smooth-scroller')

    function changeActivePage(active) {
        navItems.forEach(item => {
            if (item.classList.contains('active') && item.getAttribute('data-scroll').replace('#', '') != active)
                item.classList.remove('active')
            if (item.getAttribute('data-scroll').replace('#', '') == active)
                item.classList.add('active')
        })
    }

    document.addEventListener('scroll', () => {
    if (window.scrollY < document.querySelector('#apartments').offsetTop - 128) {
        changeActivePage(null)
      }
      else if (window.scrollY >= document.querySelector('#apartments').offsetTop - 128 && window.scrollY < document.querySelector('.divider').offsetTop - 128 ) {
        changeActivePage('apartments')
      } else if (window.scrollY >= document.querySelector('.divider').offsetTop) {
        changeActivePage('our-app')
      }
    })

}

$(".smooth-scroller").click(function(e) {
    if (location.pathname == '/') {
        e.preventDefault()
    }
    if (window.innerWidth > 976) {
        window.scrollTo(0, document.querySelector($(this).data('scroll')).offsetTop - $('nav').height())
    } else {
        document.querySelector('.nav-btn').click()
        window.scrollTo(0, document.querySelector($(this).data('scroll')).offsetTop - $('nav').height())
    }
})

document.addEventListener('scroll', () => {
    if (window.scrollY > 50) {
     if (window.innerWidth > 976) {
        document.querySelector('nav').classList.remove('orange-ww')
        document.querySelector('nav').classList.add('orange')
     } else {
        document.querySelector('nav').classList.remove('orange')
        document.querySelector('nav').classList.add('orange-ww')
    }} else {
        document.querySelector('nav').classList.remove('orange-ww')
        document.querySelector('nav').classList.remove('orange')
    }
})

document.addEventListener('DOMContentLoaded', () => {
    if (window.scrollY > 50) {
        document.querySelector('nav').classList.add('orange')
    }
})
