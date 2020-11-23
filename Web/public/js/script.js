document.querySelector('.nav-btn').addEventListener('click', () => {
    if (document.getElementById('nav').checked) {
        document.querySelector('.nav-wrapper').style.display = 'none'
    } else {
        document.querySelector('.nav-wrapper').style.display = 'block'
    }
})

window.addEventListener('resize', () => {
    if (window.innerWidth >= 864) {
        document.querySelector('.nav-wrapper').style.display = 'block'
    } else {
        document.querySelector('.nav-wrapper').style.display = 'none'
    }
})

document.addEventListener('DOMContentLoaded', () => {
    if (window.innerWidth <= 864) {
        document.querySelector('.nav-wrapper').style.display = 'none'
    }
})