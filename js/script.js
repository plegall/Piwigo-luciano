function makeNiceRatingForm(options)
{
	gRatingOptions = options || {};
	var form = $('rateForm');
	if (!form) return;

	gRatingButtons = form.getElements('input');
	gUserRating = "";
	
	gRatingButtons.each(function(el){ if ( el.type=="button" ) { gUserRating = el.value; } });

	gRatingButtons.each(function(el, i){
		
		el.initialRateValue = el.value; // save it as a property
		
		try { el.type = "button"; } catch (e){}// avoid normal submit (use ajax); not working in IE6
		
		//hide the text IE/Opera - breaks safari
		if (navigator.userAgent.indexOf('AppleWebKit/') == -1 ) el.value = ""; 
		
		el.setStyles({
			'textIndent' : "-50px",
			'marginLeft' : 0,
			'marginRight' : 0
		});

		if (i!=gRatingButtons.length-1 && el.nextSibling.nodeType == 3 /*TEXT_NODE*/)
			el.parentNode.removeChild(el.nextSibling);
			
		if (i>0 && el.previousSibling.nodeType == 3 /*TEXT_NODE*/)
			el.parentNode.removeChild(el.previousSibling);
		
		el.addEvents({
			'mouseenter' 	: function(){updateRating(el)},
			'mouseleave' 	: function(){resetRating(el)},
			'click' 		: function(e){submitRating(e)}
		});

	});
}

function resetRating(el)
{
	for (i = 1; i<gRatingButtons.length; i++){
		gRatingButtons[i].removeClass('rateButtonUserFull2');
		gRatingButtons[i].removeClass('rateButtonUserHalf2');
		gRatingButtons[i].removeClass('rateButtonUserEmpty2');
		gRatingButtons[i].removeClass('rateButtonFull2');
		gRatingButtons[i].removeClass('rateButtonHalf2');
		gRatingButtons[i].removeClass('rateButtonEmpty2');
		if(gRatingButtons[i].value > el.value) break;
	}
}

function updateRating(el)
{
	for (i = 1; i<gRatingButtons.length; i++){
																												var newClass = 'rateButton';
		if(gRatingButtons[i].title <= el.title)																		newClass = newClass+'User';
		if(gRatingButtons[i].hasClass('rateButtonFull') || gRatingButtons[i].hasClass('rateButtonUserFull'))		newClass = newClass+'Full2';
		else if(gRatingButtons[i].hasClass('rateButtonHalf') || gRatingButtons[i].hasClass('rateButtonUserHalf'))	newClass = newClass+'Half2';
		else																										newClass = newClass+'Empty2';
		gRatingButtons[i].addClass(newClass);
	}
}

function setNewRate(score, count, stdev, newRating)
{
	var score = score+"";
	ratingSplitted = score.split('.');
	starFull = ratingSplitted[0];
	starHalf = (ratingSplitted[1] > 49) ? true : false;
	
	for (i = 1; i<gRatingButtons.length; i++){
		gRatingButtons[i].removeClass('rateButtonFull');
		gRatingButtons[i].removeClass('rateButtonHalf');
		gRatingButtons[i].removeClass('rateButtonEmpty');
		gRatingButtons[i].removeClass('rateButtonUserFull');
		gRatingButtons[i].removeClass('rateButtonUserHalf');
		gRatingButtons[i].removeClass('rateButtonUserEmpty');
		gRatingButtons[i].removeClass('rateButtonFull2');
		gRatingButtons[i].removeClass('rateButtonHalf2');
		gRatingButtons[i].removeClass('rateButtonEmpty2');
		gRatingButtons[i].removeClass('rateButtonUserFull2');
		gRatingButtons[i].removeClass('rateButtonUserHalf2');
		gRatingButtons[i].removeClass('rateButtonUserEmpty2');
		
		
		if(gRatingButtons[i].title <= starFull)					gRatingButtons[i].addClass((gRatingButtons[i].title <= newRating) ? 'rateButtonUserFull': 'rateButtonFull');
		else if(gRatingButtons[i].title == starFull.toInt()+1)
			if(gRatingButtons[i].title <= newRating)			gRatingButtons[i].addClass((starHalf) ? 'rateButtonUserHalf': 'rateButtonUserEmpty');
			else												gRatingButtons[i].addClass((starHalf) ? 'rateButtonHalf': 'rateButtonEmpty');
		else													gRatingButtons[i].addClass((gRatingButtons[i].title <= newRating) ? 'rateButtonUserEmpty': 'rateButtonEmpty');
	}
}

function submitRating(e)
{
	var rateButton = e.target;
	if (rateButton.initialRateValue == gUserRating)
		return false; //nothing to do

	for (var i=0; i<gRatingButtons.length; i++) gRatingButtons[i].disabled=true;
	var y = new PwgWS(gRatingOptions.rootUrl);
	y.callService(
		"pwg.images.rate", {image_id: gRatingOptions.image_id, rate: rateButton.initialRateValue } ,
		{
			onFailure: function(num, text) {
				alert(num + " " + text);
				document.location = rateButton.form.action + "&rate="+rateButton.initialRateValue;
			},
			onSuccess: function(result)	{
				gUserRating = rateButton.initialRateValue;
				for (var i=0; i<gRatingButtons.length; i++) gRatingButtons[i].disabled=false;
				setNewRate(result.score, result.count, result.stdev, rateButton.initialRateValue);
				if (gRatingOptions.ratingSummaryElement)
				{
					var t = gRatingOptions.ratingSummaryText;
					var args =[result.score, result.count, result.stdev], idx = 0, rexp = new RegExp( /%\.?\d*[sdf]/ );
					_xxx = t.match( rexp );
					while (idx<args.length) t=t.replace(rexp, args[idx++]);
					gRatingOptions.ratingSummaryElement.innerHTML = t;
				}
			}
		}
	);
	return false;
}
