var acc = document.getElementsByClassName("accordion");
var i;

for (i = 0; i < acc.length; i++) {
    acc[i].addEventListener("click", function() {
        this.classList.toggle("accordion_active");

        /* Toggle between hiding and showing the active panel */
        var contentDiv = this.parentElement.nextElementSibling;
        if (contentDiv.style.display === "block") {
            contentDiv.style.display = "none";
        } else {
            contentDiv.style.display = "block";
        }

        var expanded = this.getAttribute('aria-expanded')
        if (expanded === 'false') {
          this.setAttribute('aria-expanded', 'true')
        } else {
          this.setAttribute('aria-expanded', 'false')
        }
    });
}

