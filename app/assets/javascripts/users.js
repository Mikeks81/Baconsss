 $(document).ready(function() {
    $(".button-collapse").sideNav();

    $(".side-nav .toggle_active").on("change", function(e){
        console.log(e.target.checked);
        $(this.closest("form")).submit();
    });
  });
