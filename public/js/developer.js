  var labels = [];
  for (var i = 1; i <= 52; i++) {
      labels.push(i);
  }

  function loadParticipation(a,b) {

    var buyerData = {
    	type: 'line',
      options: {
        scales: {
          xAxes: [{
            display: false
          }],
          yAxes: [{
            display: false
          }],
        }
      },
      data: {
        labels: labels,
      	datasets : [
      		{
            label: 'all',
      			fillColor : "transparent",
      			backgroundColor: "rgba(153,255,51,0.4)",
      			data : a
      		},
          {
            label: 'owner',
            fillColor: "transparent",
            backgroundColor: "rgba(255,153,0,0.4)",
            data: b
          }
      	]
      }
    }
    return buyerData;
  }
