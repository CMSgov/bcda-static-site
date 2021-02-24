{% assign code = include.code %}
{% assign aco = include.aco %}
{% assign type = include.type %}
{% assign nanosecond = "now" | date: "%N" %}
<div class="highlight" aria-hidden="true"><pre><code id="code{{ nanosecond }}">{{code}}</code></pre></div>

<div class="button" on>
    <p>
        <button class="ds-c-button" type="button" href="javascript:void(0)" onclick='copyText{{ nanosecond }}();metricTagging("BCDA", "Try the API: Accordion: Copy to Clipboard", "{{ type }}:{{ aco }}")' id="copybutton{{ nanosecond }}" aria-label="Copy {{ aco }} {{ type }} to clipboard">Copy to clipboard</button>
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
