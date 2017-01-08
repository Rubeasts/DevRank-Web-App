  var labels = [];
  for (var i = 1; i <= 52; i++) {
      labels.push(i);
  }

  function loadParticipation(a) {

    var buyerData = {
    	labels : labels,
    	datasets : [
    		{
    			fillColor : "rgba(172,194,132,0.4)",
    			strokeColor : "#ACC26D",
    			pointColor : "#fff",
    			pointStrokeColor : "#9DB86D",
    			data : a
    		}
    	]
    }
    return buyerData;
  }
