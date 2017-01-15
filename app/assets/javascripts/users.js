 $(document).on('turbolinks:load', function() {
    var sideNav = document.getElementsByClassName('side-nav fixed'),
        showContainer = document.getElementById('show-container');
    $(".button-collapse").sideNav();

    // when profile is toggled this submits form.
    $(".side-nav .toggle_active").on("change", function(e){
        console.log(e.target.checked);
        $(this.closest("form")).submit();
    });

    if (sideNav) {
      showContainer.className = 'col s7 offset-s4';
    }


  });
