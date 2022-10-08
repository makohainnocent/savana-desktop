

const mediaConstraintsCamera = {
    audio: true, // We want an audio track
    video: true // And we want a video track
};

const mediaConstraintsScreen={
    video:{
        cursor:"never"
    },
    audio:false
}

const mediaConstraintsMicrophone = {
  audio: true, // We want an audio track
};

var myPeerConnection=0;
var remoteAddress
var commandId
var computer_serial
var userId
var mediaStreamType


window.onload=function(){
  getCommandDetails()
}
  
  function inviteWithCamera() {
    if (myPeerConnection!=0) {
      //alert("You can't start a call because you already have one open!");
    } else {
    
      createPeerConnection();
  
      navigator.mediaDevices.getUserMedia(mediaConstraintsCamera)
        .then((localStream) => {
          document.getElementById("local_video").srcObject = localStream;
          localStream.getTracks().forEach((track) => myPeerConnection.addTrack(track, localStream));
        })
        .catch(handleGetUserMediaError);
    }
  }

  function inviteWithMicrophone() {
    if (myPeerConnection!=0) {
      alert("You can't start a call because you already have one open!");
    } else {
    
      createPeerConnection();
  
      navigator.mediaDevices.getUserMedia(mediaConstraintsMicrophone)
        .then((localStream) => {
          document.getElementById("local_video").srcObject = localStream;
          localStream.getTracks().forEach((track) => myPeerConnection.addTrack(track, localStream));
        })
        .catch(handleGetUserMediaError);
    }
  }

  function inviteWithScreen() {
    if (myPeerConnection!=0) {
      alert("You can't start a call because you already have one open!");
    } else {
    
      createPeerConnection();
  
      navigator.mediaDevices.getDisplayMedia(mediaConstraintsScreen)
        .then((localStream) => {
          document.getElementById("local_video").srcObject = localStream;
          localStream.getTracks().forEach((track) => myPeerConnection.addTrack(track, localStream));
        })
        .catch(handleGetUserMediaError);
    }
  }



  function handleGetUserMediaError(e) {
    switch(e.name) {
      case "NotFoundError":
        alert("Unable to open your call because no camera and/or microphone" +
              "were found.");
        break;
      case "SecurityError":
      case "PermissionDeniedError":
        // Do nothing; this is the same as the user canceling the call.
        break;
      default:
        alert(`Error opening your camera and/or microphone: ${e.message}`);
        break;
    }
  
    closeVideoCall();
  }


  function createPeerConnection() {
    myPeerConnection = new RTCPeerConnection({
        iceServers: [     // Information about ICE servers - Use your own!
          {
            urls: "stun:stun.stunprotocol.org"
          },
          {
            urls: "stun:openrelay.metered.ca:80",
          },
          {
            urls: "turn:openrelay.metered.ca:80",
            username: "openrelayproject",
            credential: "openrelayproject",
          },
          {
            urls: "turn:openrelay.metered.ca:443",
            username: "openrelayproject",
            credential: "openrelayproject",
          },
          {
            urls: "turn:openrelay.metered.ca:443?transport=tcp",
            username: "openrelayproject",
            credential: "openrelayproject",
          }
        ]
    });
  
    myPeerConnection.onicecandidate = handleICECandidateEvent;
    myPeerConnection.ontrack = handleTrackEvent;
    myPeerConnection.onnegotiationneeded = handleNegotiationNeededEvent;
    myPeerConnection.onremovetrack = handleRemoveTrackEvent;
    myPeerConnection.oniceconnectionstatechange = handleICEConnectionStateChangeEvent;
    myPeerConnection.onicegatheringstatechange = handleICEGatheringStateChangeEvent;
    myPeerConnection.onsignalingstatechange = handleSignalingStateChangeEvent;
  }


  function handleNegotiationNeededEvent() {
    myPeerConnection.createOffer()
      .then((offer) => myPeerConnection.setLocalDescription(offer))
      .then(() => {
        sendToServer({
          type: "video-offer",
          sdp: myPeerConnection.localDescription
        });
      })
      .catch(reportError);
  }


  function sendToServer(msg){
    if(msg.type=="video-offer"){
      sendVideoOffer(msg.sdp)
    }

    if(msg.type=="video-answer"){
      sendVideoAnswer(msg.sdp)
    }

    if(msg.type=="new-ice-candidate"){
      sendIceCandidate(msg.candidate)
    }
  }

  function sendVideoOffer(sdp){
    $.ajax({
      url:remoteAddress+"/putMessage",
      method:"post",
      async:false,
      data:{
          to:userId,
          from:computer_serial,
          message:JSON.stringify(sdp),
          attachements:0,
          sdp:1,
          ice:0,
          text:0,
          files:0,
          read:0,
          mediaStreamType:0,

      },
      success:function(data){
        console.log(data)
      },
      error:function(error){
        alert(error)
      }
  })
  }

  function sendVideoAnswer(sdp){
    $.ajax({
      url:remoteAddress+"/putMessage",
      method:"post",
      async:false,
      data:{
          to:userId,
          from:computer_serial,
          message:JSON.stringify(sdp),
          attachements:0,
          sdp:1,
          ice:0,
          text:0,
          files:0,
          read:0,
          mediaStreamType:0,

      },
      success:function(data){
        console.log(data)
      },
      error:function(error){
        //abortSession("could not get command details")
      }
  })
  }


  function sendIceCandidate(candidate){
    $.ajax({
      url:remoteAddress+"/putMessage",
      method:"post",
      async:false,
      data:{
          to:userId,
          from:computer_serial,
          message:JSON.stringify(candidate),
          attachements:0,
          sdp:0,
          ice:1,
          text:0,
          files:0,
          read:0,
          mediaStreamType:0,

      },
      success:function(data){
        console.log(data)
      },
      error:function(error){
        //abortSession("could not get command details")
      }
  })
  }


  function handleVideoAnswerMsg(msg) {
    const desc = new RTCSessionDescription(JSON.parse(msg));
    myPeerConnection.setRemoteDescription(desc)
  }


  function handleICECandidateEvent(event) {
    if (event.candidate) {
      sendToServer({
        type: "new-ice-candidate",
        candidate: event.candidate
      });
    }
  }

  function handleNewICECandidateMsg(msg) {
    const candidate = new RTCIceCandidate(JSON.parse(msg));
  
    myPeerConnection.addIceCandidate(candidate)
      .catch(reportError);
  }


  function handleTrackEvent(event) {
    document.getElementById("received_video").srcObject = event.streams[0];
    document.getElementById("hangup-button").disabled = false;
  }

  function handleRemoveTrackEvent(event) {
    const stream = document.getElementById("received_video").srcObject;
    const trackList = stream.getTracks();
  
    if (trackList.length === 0) {
      closeVideoCall();
    }
  }

  
  function hangUpCall() {
    closeVideoCall();
    sendToServer({
      type: "hang-up"
    });
  }


  function closeVideoCall() {
    const remoteVideo = document.getElementById("received_video");
    const localVideo = document.getElementById("local_video");
  
    if (myPeerConnection) {
      myPeerConnection.ontrack = null;
      myPeerConnection.onremovetrack = null;
      myPeerConnection.onremovestream = null;
      myPeerConnection.onicecandidate = null;
      myPeerConnection.oniceconnectionstatechange = null;
      myPeerConnection.onsignalingstatechange = null;
      myPeerConnection.onicegatheringstatechange = null;
      myPeerConnection.onnegotiationneeded = null;
  
      if (remoteVideo.srcObject) {
        remoteVideo.srcObject.getTracks().forEach((track) => track.stop());
      }
  
      if (localVideo.srcObject) {
        localVideo.srcObject.getTracks().forEach((track) => track.stop());
      }
  
      myPeerConnection.close();
      myPeerConnection = null;
    }
  
    remoteVideo.removeAttribute("src");
    remoteVideo.removeAttribute("srcObject");
    localVideo.removeAttribute("src");
    remoteVideo.removeAttribute("srcObject");
  
    document.getElementById("hangup-button").disabled = true;
    targetUsername = null;
  }


  function handleICEConnectionStateChangeEvent(event) {
    switch(myPeerConnection.iceConnectionState) {
      case "closed":
      case "failed":
        closeVideoCall();
        break;
    }
  }


  function handleICEGatheringStateChangeEvent(event) {
    // Our sample just logs information to console here,
    // but you can do whatever you need.
  }

  function handleSignalingStateChangeEvent(event) {
    switch(myPeerConnection.signalingState) {
      case "closed":
        closeVideoCall();
        break;
    }
  };

  function getCommandDetails(){
    getRemoteAddress()
    getCommandId()
    
    //get details of the command
    $.ajax({
      url:remoteAddress+"/getCommandDetails",
      method:"post",
      async:false,
      data:{commandId:commandId},
      success:function(data){
        console.log(data)
        computer_serial=data.to
        userId=data.from
        putCommandFeedback("streaming will start soon")
        putCommandStatus("SUCCESS")
      },
      error:function(error){
        abortSession("could not get command details")
      }
     })
    
    setInterval(messagePolling,5000);
  }

  async function getRemoteAddress(){
   $.ajax({
    url:"address.html",
    methode:"get",
    async:false,
    success:function(data){
      remoteAddress=data
    },
    error:function(error){
      abortSession("could not get remote address")
    }
   })
  }

  function getCommandId(){
    $.ajax({
      url:"commandId.html",
      methode:"get",
      async:false,
      success:function(data){
        commandId=data
      },
      error:function(error){
        abortSession("could not get command id")
      }
     })
  }


 


  function abortSession(msg){
    alert(msg)
  }

  function putCommandFeedback(feedback){
    $.ajax({
      url:remoteAddress+"/putCommandFeedBack",
      method:"post",
      async:false,
      data:{id:commandId,feedback:feedback},
      success:function(data){
        console.log(data)
      },
      error:function(error){
        //abortSession("could not get command details")
      }
     })
  }

  function putCommandStatus(status){
    $.ajax({
      url:remoteAddress+"/putCommandStatus/commandId/"+commandId+"/status/"+status,
      method:"get",
      async:false,
      success:function(data){
        console.log(data)
      },
      error:function(error){
        //abortSession("could not get command details")
      }
     })
  }

function messagePolling(){
  $.ajax({
    url:remoteAddress+"/getMessage",
    method:"post",
    async:false,
    data:{for:computer_serial},
    success:function(data){
      console.log(data)
      if(data[0].mediaStreamType=="1"){
        MediaStreamTypeMessage(data[0].message)
      }
      if(data[0].ice=="1"){
        handleNewICECandidateMsg(data[0].message)
      }
      if(data[0].sdp=="1"){
        handleVideoAnswerMsg(data[0].message)
      }
    },
    error:function(error){
      //abortSession("could not get command details")
    }
   })
}

function MediaStreamTypeMessage(message){
  mediaStreamType=message
  
  if(mediaStreamType=="C"){
    inviteWithCamera()
  }

  if(mediaStreamType=="M"){
    inviteWithMicrophone()
  }

  if(mediaStreamType=="S"){
    inviteWithScreen()
  }
}