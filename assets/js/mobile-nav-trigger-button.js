var acc = document.getElementsByClassName("mobile-nav-trigger-button");
var i;

for (i = 0; i < acc.length; i++) {
    acc[i].addEventListener("click", function() {
        var expanded = this.getAttribute('aria-expanded')
        if (expanded === 'false') {
          this.setAttribute('aria-expanded', 'true')
        } else {
          this.setAttribute('aria-expanded', 'false')
        }
    });
}

