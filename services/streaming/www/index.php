<div class="flexChild" id="camera-container">
  <div class="camera-box">
    <video id="received_video" controls autoplay style="width:300px;height:300px;border-color:blue;border-style:solid"></video>
    <video id="local_video" controls autoplay muted style="width:300px;height:300px;border-color:green;border-style:solid"></video>
    <button id="hangup-button" onclick="hangUpCall();" disabled>Hang Up</button>
  </div>
</div>


<script src="jquery/jquery.min.js"></script>
<script src="index.js"></script>