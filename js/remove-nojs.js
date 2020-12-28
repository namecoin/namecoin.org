// remove nojs
document.documentElement.classList.remove("nojs");

// random tagline
var taglines = document.getElementById("tagline").getElementsByClassName("candidate-tagline");
var rand_tagline = taglines[Math.floor(Math.random() * taglines.length)];

rand_tagline.removeAttribute("hidden");
