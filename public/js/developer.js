function resize(){
    $("#canvas").outerHeight($(window).height()-$("#canvas").offset().top- Math.abs($("#canvas").outerHeight(true) - $("#canvas").outerHeight()));
  }
  $(document).ready(function(){
    resize();
    $(window).on("resize", function(){
        resize();
    });
  });



  var buyerData = {
  	labels : ["January","February","March","April","May","June"],
  	datasets : [
  		{
  			fillColor : "rgba(172,194,132,0.4)",
  			strokeColor : "#ACC26D",
  			pointColor : "#fff",
  			pointStrokeColor : "#9DB86D",
  			data : [203,156,99,251,305,247]
  		}
  	]
  }
