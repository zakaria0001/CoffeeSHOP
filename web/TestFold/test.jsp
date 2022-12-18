 <style>
        *{
 margin:0;
}
html, body {
 height:100%;
 background-color:red
}
.overlay {
 position:absolute;
 display:none;
 top:0;
 right:0;
 bottom:0;
 left:0;
 background:rgba(0, 0, 0, 0.8);
 z-index:9999;
}
.close {
 position:absolute;
 top:-40px;
 right:-5px;
 z-index:99;
 width:25px;
 height:25px;
 cursor:pointer;
 color: #fff;
 display: inline-block;
}
.popup {
 position:absolute;
 width:50%;
 height:50%;
 top:25%;
 left:25%;
 text-align:center;
 border-radius: 10px;
 background:white;
 box-shadow: 0px 0px 10px 0px black;
}
.popup h2 {
 font-size:15px;
 height:50px;
 line-height:50px;
 color:#fff;
 background:rgb(24, 108, 209);
 border-radius:10px 10px 0px 0px;
}
.button {
 width:50px;
 height:50px;
 color:#fff;
 font-weight:bolder;
 border-radius:10px;
 background:silver;
}
    </style>
<div class='overlay'>
    <div class='popup'>
        <div class='close'>&#10006;</div><!-- close button-->
         <h2>Popup</h2> <!-- title food the popup-->
        
    </div>
</div>


<button class="button">Show</button>
     
    <script src="../style/jquery.min.js"></script>
    <script>
        $('.button').click(function () {
  $('.overlay').show();
})
$('.close').click(function () {
  $('.overlay').hide();
})
    </script>