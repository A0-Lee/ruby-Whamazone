// There is a bug with turbolinks-preview where if the hidden message was activated beforehand
// the hidden message will still be cached before displaying the original message after a page reload
document.addEventListener("turbolinks:load", function() {
  $(document).ready(function() {
    $("#author").click(function() {
      $(this).replaceWith("<a id='hidden'> I hope you enjoy viewing my coursework Andrew! </a>");
      console.log("Hidden message activated!");
    });
  });
});
