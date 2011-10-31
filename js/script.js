window.addEvent('domready', function() {
	galleryThumbs = $$('.thumbnailCategories li');
	galleryThumbs.each(function(el){
		el.linkUrl = el.getElement('a').href;
		el.addEvents({
			'mouseenter'	: function(){addOver(el)},
			'mouseleave'	: function(){removeOver(el)},
			'click'			: function(){goToUrl(el)}
		});
	});
	
	catThumbs = $$('.thumbnails li');
	catThumbs.each(function(el){
		el.addEvents({
			'mouseenter'	: function(){addOver(el)},
			'mouseleave'	: function(){removeOver(el)}
		});
	});
	
	var mySelect = new elSelect( {container : 'order', onClicked: function(){new URI(this.hiddenInput.value).go();}} );
  var themeSelect = new elSelect( {container : 'themeSelect'} );
  var languageSelect = new elSelect( {container : 'languageSelect'} );
	
	var photoPrev = $('linkPrev');
	
	if(photoPrev)
	{
		photoPrev.image = photoPrev.getElement('img');
		photoPrev.image.setStyle('opacity', 0);
		photoPrev.setStyle('display', 'block');
		photoPrev.addEvents({
			'mouseenter': function(){ showElement(photoPrev.image) },
			'mouseleave': function(){ hideElement(photoPrev.image)}
		});
	}
	
	var photoNext = $('linkNext');
	if(photoNext)
	{
		photoNext.image = photoNext.getElement('img');
		photoNext.image.setStyle('opacity', 0);
		photoNext.setStyle('display', 'block');
		photoNext.addEvents({
			'mouseenter': function(){ showElement(photoNext.image) },
			'mouseleave': function(){ hideElement(photoNext.image)}
		});
	}
});

function addOver(el){
	if(!el.hasClass('hover')) el.addClass('hover');
}

function removeOver(el){
	if(el.hasClass('hover')) el.removeClass('hover');
}

function goToUrl(el){
	new URI(el.linkUrl).go();
}

function showElement(el)
{
	el.morph({'opacity': 1});
}

function hideElement(el)
{
	el.morph({'opacity': 0});
}

function toggleElement(el)
{
	if(el.getStyle('opacity') == 0) showElement(el); else hideElement(el);
}

var gRatingOptions, gRatingButtons, gUserRating;

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


/**
* @file elSelect.js
* @downloaded from http://www.cult-f.net/2007/12/14/elselect/
* @hacked by Luciano Amodio www.lucianoamodio.it
* @author Sergey Korzhov aka elPas0
* @site  http://www.cult-f.net
* @date December 14, 2007
* 
*/
var elSelect = new Class({
	options: {
		container: false,
		baseClass : 'elSelect',
		onClicked: $lambda(false)
	},
	source : false,
	selected : false,
	_select : false,
	current : false,
	selectedOption : false,
	dropDown : false,
	optionsContainer : false,
	hiddenInput : false,
	/*
	pass the options,
	create html and inject into container
	*/
	initialize: function(options){
		this.setOptions(options)
		
		if ( !$(this.options.container) ) return
		
		this.selected = false
		this.source = $(this.options.container).getElement('select')
		this.buildFrameWork()
		
		$(this.source).getElements('option').each( this.addOption, this )
		$(this.options.container).set('html', '')
		this._select.injectInside($(this.options.container))
		
		this.bindEvents()
		
	},
	
	buildFrameWork : function() {
		this._select = new Element('div').addClass( this.options.baseClass )
		this.current = new Element('div').addClass('selected').injectInside($(this._select))
		this.selectedOption = new Element('div').addClass('selectedOption').injectInside($(this.current))
		this.dropDown = new Element('div').addClass('dropDown').injectInside($(this.current))
		new Element('div').addClass('clear').injectInside($(this._select))
		this.optionsContainer = new Element('div').addClass('optionsContainer').injectInside($(this._select))
		var t = new Element('div').addClass('optionsContainerTop').injectInside($(this.optionsContainer))
		var o = new Element('div').injectInside($(t))
		var p = new Element('div').injectInside($(o))
		var t = new Element('div').addClass('optionsContainerBottom').injectInside($(this.optionsContainer))
		var o = new Element('div').injectInside($(t))
		var p = new Element('div').injectInside($(o))

		this.hiddenInput = new Element('input', {
			'type'  : 'hidden',
			'name'  : this.source.get('name')				
		}).inject($(this.options.container), 'before');
		
	},
	
	bindEvents : function() {
		document.addEvent('click', function() { 
				if ( this.optionsContainer.getStyle('display') == 'block') 
					this.onDropDown()
			}.bind(this));
			
		$(this.options.container).addEvent( 'click', function(e) { new Event(e).stop(); } )		
		this.current.addEvent('click', this.onDropDown.bindWithEvent(this) )
		
	},
	
	//add single option to select
	addOption: function( option ){
    	var o = new Element('div').addClass('option').setProperty('value',option.value)
		if ( option.disabled ) { o.addClass('disabled') } else {
			o.addEvents( {
				'click': this.onOptionClick.bindWithEvent(this),
				'mouseout': this.onOptionMouseout.bindWithEvent(this),
				'mouseover': this.onOptionMouseover.bindWithEvent(this)
			})
		}
		
		if ( $defined(option.getProperty('class')) && $chk(option.getProperty('class')) ) 
			o.addClass(option.getProperty('class'))

	
		if ( option.selected ) { 
			if ( this.selected) this.selected.removeClass('selected');
			this.selected = o
			o.addClass('selected')
			this.selectedOption.set('text', option.text);
			this.hiddenInput.setProperty('value',option.value);
		}
		o.set('text', option.text);	
		o.injectBefore($(this.optionsContainer).getLast());
	},
	
	onDropDown : function( e ) {
			
			if ( this.optionsContainer.getStyle('display') == 'block') {
				this.optionsContainer.setStyle('display','none')
			} else {
				this.optionsContainer.setStyle('display','block')
				this.selected.addClass('selected')
				//needed to fix min-width in ie6
				var width =  this.optionsContainer.getStyle('width').toInt() > this._select.getStyle('width').toInt() ?
															this.optionsContainer.getStyle('width')
															:
															this._select.getStyle('width')
															
				this.optionsContainer.setStyle('width', width)
				this.optionsContainer.getFirst().setStyle('width', width)
				this.optionsContainer.getLast().setStyle('width', width)
			}						
	},
	onOptionClick : function(e) {
		var event = new Event(e)
		if ( this.selected != event.target ) {
			this.selected.removeClass('selected')
			event.target.addClass('selected')
			this.selected = event.target
			this.selectedOption.set('text', this.selected.get('text'));
			this.hiddenInput.setProperty('value',this.selected.getProperty('value'));
			this.fireEvent('clicked');
		}
		this.onDropDown()
	},
	onOptionMouseover : function(e){
		var event = new Event(e)
		this.selected.removeClass('selected')
		event.target.addClass('selected')
	},
	onOptionMouseout : function(e){
		var event = new Event(e)
		event.target.removeClass('selected')
	}
	
});
elSelect.implement(new Events);
elSelect.implement(new Options);