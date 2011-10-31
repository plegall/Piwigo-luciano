<div id="imageHeaderBar">
	<div class="imageNumber">{$PHOTO}</div>
</div>

{include file='picture_nav_keys.tpl'|@get_extent:'picture_nav_keys'}

<div id="slidshowToolBar">{include file='picture_nav_buttons.tpl'|@get_extent:'picture_nav_buttons'}</div>
<div id="imageContainer">
	<div id="theImage">
		<div id="theImg"><a href="{$U_SLIDESHOW_STOP}">{$ELEMENT_CONTENT}</a></div>
	</div>
</div>