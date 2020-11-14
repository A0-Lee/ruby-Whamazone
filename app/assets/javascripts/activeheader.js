document.addEventListener("turbolinks:load", function() {
  $(document).ready(function() {
      $('a').each(function() {
        // This function checks if the url link matches to the href link of the nav-bar item
          if ($(this).prop('href') == window.location.href) {
            // If it does, then add the active class the the li tag (parent of item a)
            // This makes the current nav-bar item highlighted white (for a good user experience)
            $(this).parents('li').addClass('active');
          }
      });
  });
});
