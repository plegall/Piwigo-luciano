<div id="imageHeaderBar">
	<div class="imageNumber">{$PHOTO}</div>
</div>
<div id="slidshowToolBar">{include file='picture_nav_buttons.tpl'|@get_extent:'picture_nav_buttons'}</div>
<div id="imageContainer">
	<div id="theImage">
		<a href="{$U_SLIDESHOW_STOP}">{$ELEMENT_CONTENT}</a>
	</div>
</div>