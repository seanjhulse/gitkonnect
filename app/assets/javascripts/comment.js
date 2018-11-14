document.addEventListener('DOMContentLoaded', function() {
  var commentParents = document.getElementsByClassName('close-thread-button');
  for(var i = 0; i < commentParents.length; i++) {
    commentParents[i].addEventListener('click', function(event) {
      event.target.nextElementSibling.nextElementSibling.classList.toggle('hide');
      console.log(event.target);
      if(event.target.nextElementSibling.nextElementSibling.classList.contains('hide')) {
        event.target.innerHTML = '[+]';
      } else {
        event.target.innerHTML = '[-]';        
      }
    })
  }
});

var cancelReplyButton = function(event) {
  document.getElementById('reply-form').remove();
}