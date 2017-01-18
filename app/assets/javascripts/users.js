 $(document).on('turbolinks:load', function() {
     var sideNav = document.getElementsByClassName('side-nav fixed'),
         showContainer = document.getElementById('show-container');

     $(".button-collapse").sideNav();

     // when profile is toggled this submits form.
     $(".side-nav .toggle_active").on("change", function(e) {
         console.log(e.target.checked);
         $(this.closest("form")).submit();
     });

     if (sideNav) {
         showContainer.className = 'col l7 offset-l4';
     }
 });

// animates string into a defined element with trails ...'s
 var interval;
 var animateEtc = function(string = "", element = "", boolean) {
     var count = 1;
     if (!boolean) {
         clearInterval(interval);
         return string;
     }
     interval = setInterval(function() {
         if (count === 4) {
             count = 1
         }
         element.text(string + (".".repeat(count)));
         count++;
     }, 500);
 }
