---
---

(function(a,b,c,d){
  a='https://tags.tiqcdn.com/utag/cmsgov/cms-general/{{ jekyll.environment }}/utag.js';
  b=document;c='script';d=b.createElement(c);d.src=a;
  d.type='text/java'+c;d.async=true;
  a=b.getElementsByTagName(c)[0];a.parentNode.insertBefore(d,a);
})();

function metricTagging(category, action, label) {
    utag.link({ ga_event_category: category, ga_event_action: action, ga_event_label: label });
};
