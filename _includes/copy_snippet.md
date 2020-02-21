{% assign code = include.code %}

{% assign nanosecond = "now" | date: "%N" %}
<div class="highlight"><pre class="highlight"><code id="code{{ nanosecond }}">{{code}}</code></pre></div>

<div class="button" on>
    <p>
        <a href="javascript:void(0)" onclick="copyText{{ nanosecond }}()" id="copybutton{{ nanosecond }}">
          Copy to clipboard
        </a>
    </p>
</div>

<script>
function copyText{{ nanosecond }}(){
  var range = document.createRange();
  range.selectNode(document.getElementById("code{{ nanosecond }}"));    // find element
  window.getSelection().removeAllRanges();                              // clear current selection
  window.getSelection().addRange(range);                                // select text
  document.execCommand("copy");                                         // copy text
  window.getSelection().removeAllRanges();                              // deselect
}
</script>
