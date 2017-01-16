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


    //  var animateEtc = function(string){
    //    var count = 0;
    //    while (count < 4){
    //      console.log("running...");
    //      setTimeout(function(){
    //       // manip dom here to show manip'd string every second
    //
    //      },1000);
    //    }
    //  }

 });
