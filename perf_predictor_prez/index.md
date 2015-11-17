---
title       : Interactive Loan Performance Predictor
subtitle    : Putting the user in control
author      : Wally Thornton
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [bootstrap, shiny, interactive]
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---
    
## Problem: No one trusts the model

### It's said that 80% of data science is data wrangling and cleaning.

That leaves 20% for modeling and testing. But what about the time required to communicate, convince and deploy models?

<img src="assets/img/black_box.jpg", width=300px, style="float:right; margin: 0 0 10px 15px">
Data scientists all too often present their models as plug-and-play black boxes. Maybe, just maybe, we take the time to explain the model or create a presentation, but that's not the best way to ensure all our hard work actually gets used.

People don't need to [grok](https://en.wikipedia.org/wiki/Grok) how or why our models work, they just need to understand enough to trust that the rest of our work is reliable.

We built a fairly complex random forest model to predict performance of a specific portfolio of loans. Imagine the difficulty of explaining how such a model works and why it should be trusted.

This is why we built the Interactive Loan Performance Predictor app.

--- &twocolvar w1:30% w2:60%

## What's more likely to lead to understanding?

*** =left

<span style="font-size: 0.7em; line-height: 0.75em">"During 2008, sales of apples increased in our Western region, reversing during 2009, although expenses stayed more or less even. Meanwhile, orange revenues stayed flat in 2008 in the Eastern region, but in 2009, expenses shot up, all while banana sales bottomed out by 2010, as did their expenses. The net result was that, thanks to apples, our profits peaked at the beginning of 2009 and shrank to their smallest amount to date by the end of that year."</span>

*** =right
or, **Interactivity** (press Play):
<span style="margin: 0 auto">
<!-- MotionChart generated in R 3.1.2 by googleVis 0.5.9 package -->
<!-- Tue Nov 17 12:52:43 2015 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataMotionChartIDfde7a19a526 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 "Apples",
2008,
"West",
98,
78,
20,
"2008-12-31" 
],
[
 "Apples",
2009,
"West",
111,
79,
32,
"2009-12-31" 
],
[
 "Apples",
2010,
"West",
89,
76,
13,
"2010-12-31" 
],
[
 "Oranges",
2008,
"East",
96,
81,
15,
"2008-12-31" 
],
[
 "Bananas",
2008,
"East",
85,
76,
9,
"2008-12-31" 
],
[
 "Oranges",
2009,
"East",
93,
80,
13,
"2009-12-31" 
],
[
 "Bananas",
2009,
"East",
94,
78,
16,
"2009-12-31" 
],
[
 "Oranges",
2010,
"East",
98,
91,
7,
"2010-12-31" 
],
[
 "Bananas",
2010,
"East",
81,
71,
10,
"2010-12-31" 
] 
];
data.addColumn('string','Fruit');
data.addColumn('number','Year');
data.addColumn('string','Location');
data.addColumn('number','Sales');
data.addColumn('number','Expenses');
data.addColumn('number','Profit');
data.addColumn('string','Date');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartMotionChartIDfde7a19a526() {
var data = gvisDataMotionChartIDfde7a19a526();
var options = {};
options["width"] =    450;
options["height"] =    400;
options["state"] = "";

    var chart = new google.visualization.MotionChart(
    document.getElementById('MotionChartIDfde7a19a526')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "motionchart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartMotionChartIDfde7a19a526);
})();
function displayChartMotionChartIDfde7a19a526() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartMotionChartIDfde7a19a526"></script>
 
<!-- divChart -->
  
<div id="MotionChartIDfde7a19a526" 
  style="width: 450; height: 400;">
</div>
</span>

---

## User-Friendly, Interactive Model
<q>Tell me and I forget, teach me and I may remember, involve me and I learn.</q>
<div class="author">Benjamin Franklin</div>
<br>

In addition to our full model, we built a simplified version of the model and made it interactive. Now, the executive team can adjust inputs and see the results for themselves. There's no longer an urge to understand or question the functionality of our full-featured "black box" because the box has been made more transparent.

Our app is critical to getting full-team buy-in:
> 1. Do all necessary data wrangling and modeling 
> 2. Build full, production-ready model 
> 3. Build scaled-down interactive model 
> 4. Give scaled-down model to stakeholders 
> 5. Watch as they sell themselves on your full model 

---

## The Performance Predictor App

The Interactive Loan Performance Predictor not only runs valid machine learning models on real data, it does a superior job of helping the audience understand how the app predicts the performance of our loans.
([https://wthornton.shinyapps.io/Loan_Performance_Predictor](https://wthornton.shinyapps.io/Loan_Performance_Predictor))

<iframe src="https://wthornton.shinyapps.io/Loan_Performance_Predictor"></iframe>
