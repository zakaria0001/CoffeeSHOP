   setTimeout(() => {
  const message = document.getElementById('message');

  message.style.display = 'none';
}, 2000); //


$('.OrderButton').click(function () {
  $('.overlay').show();
})
$('.close').click(function () {
  $('.overlay').hide();
})
