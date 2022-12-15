// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "bootstrap";
import "trix";
import "@rails/actiontext";

$(function () {
  $(".dropdown-menu").click(function (e) {
    e.stopPropagation();
  });
  $(".vote").on("click", ".upvote, .downvote", function () {
    let post_id = $(this).parent().attr("data-id");
    let is_upvote = $(this).hasClass("upvote");
    let signed_in = $(this).parent().attr("data-account")
    
    if (signed_in === "true" ) {
      $.ajax({
        url: "/posts/vote",
        method: "POST",
        data: { post_id: post_id, upvote: is_upvote },
      });
    } else if (signed_in === "false") {
      alert("Please login or signup to vote on posts!")
    }

  });
});import "trix"
import "@rails/actiontext"
