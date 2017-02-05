 $(document).on('turbolinks:load', function() {
     var showContainer = document.getElementById('show-container');

     $(".button-collapse").sideNav();

     // when profile is toggled this submits form.
     $(".toggle_active").on("change", function(e) {
         console.log(e.target.checked);
         $(this.closest("form")).submit();
     });


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
