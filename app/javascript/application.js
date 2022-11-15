// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "bootstrap";

$(function () {
  $(".vote").on("click", ".upvote, .downvote", function () {
    let post_id = $(this).parent().attr("data-id");
    let is_upvote = $(this).hasClass("upvote")

    $.ajax({
      url: "/posts/vote",
      method: "POST",
      data: { post_id: post_id, upvote: is_upvote },
    });
  });
});

// $(function () {
//   $(".vote").on("click", ".downvote", function () {
//     let post_id = $(this).parent().attr("data-id");
//     console.log("downvote " + post_id);
//   });
// });
