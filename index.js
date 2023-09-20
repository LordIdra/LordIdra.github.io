let canvas = document.getElementById("canvas")

function resizeCanvas() {
    if (window.innerWidth / window.innerHeight < 1) {
        console.log(window.innerWidth)
        canvas.width = window.innerWidth * 1.0;
        canvas.height = window.innerHeight * 1.0;
    } else {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    }
}

function onScroll() {
    const fadeOutBy = 400;
    const currentScroll = window.scrollY;
    if (currentScroll <= fadeOutBy) {
        opacity = 1 - currentScroll / fadeOutBy;
    } else {
        opacity = 0;
    }

    Array.prototype.forEach.call(document.getElementById("title-div").children, element => {
        if (opacity > 0) {
            element.style.opacity = opacity
        }
    });

    if (opacity == 0) {
        document.getElementById("title-div").style.visibility = "hidden"
    } else {
        document.getElementById("title-div").style.visibility = "visible"
    }
}

window.addEventListener("scroll", onScroll);
window.addEventListener('resize', resizeCanvas);
resizeCanvas()