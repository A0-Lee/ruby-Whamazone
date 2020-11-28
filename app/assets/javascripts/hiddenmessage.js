// You've found the hidden easter egg!
document.addEventListener("turbolinks:load", function() {
  $(document).ready(function() {
    $("#author").click(function() {
      $(this).replaceWith("<a id='hidden'> I hope you enjoy viewing my coursework, Andrew! </a>");
      console.log("Hidden message activated!");
    });
  });
});
