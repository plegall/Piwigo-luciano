<div class="navButtons">

	{if isset($first)}
	<a class="navButton" href="{$first.U_IMG}" title="{'first_page'|@translate} : {$first.TITLE}" rel="first"><img src="{$ROOT_URL}{$themeconf.icon_dir}/first.png" class="button" alt="{'first_page'|@translate}"></a>
	{else}
	<a class="navButton"><img src="{$ROOT_URL}{$themeconf.icon_dir}/first_unactive.png" class="button" alt=""></a>
	{/if}
	
	{if isset($previous)}
	<a class="navButton" href="{$previous.U_IMG}" title="{'previous_page'|@translate} : {$previous.TITLE}" rel="prev"><img src="{$ROOT_URL}{$themeconf.icon_dir}/left.png" class="button" alt="{'previous_page'|@translate}"></a>
	{else}
	<a class="navButton"><img src="{$ROOT_URL}{$themeconf.icon_dir}/left_unactive.png" class="button" alt=""></a>
	{/if}
	
	{if isset($U_SLIDESHOW_STOP)}
	<a class="navButton" href="{$U_SLIDESHOW_STOP}" title="{'slideshow_stop'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/stop_selected.png" class="button" alt="{'slideshow_stop'|@translate}"></a>
	{/if}
	
	{if isset($slideshow.U_START_PLAY)}
	<a class="navButton" href="{$slideshow.U_START_PLAY}" title="{'slideshow_play'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/play.png" class="button" alt="{'slideshow_play'|@translate}"></a>
	{/if}
	
	{if isset($slideshow.U_STOP_PLAY)}
	<a class="navButton" href="{$slideshow.U_STOP_PLAY}" title="{'stop_play'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/pause.png" class="button" alt="{'stop_play'|@translate}"></a>
	{/if}
	
	{if isset($U_UP) and !isset($slideshow)}
	<a class="navButton" href="{$U_UP}" title="{'thumbnails'|@translate}" rel="up"><img src="{$ROOT_URL}{$themeconf.icon_dir}/up.png" class="button" alt="{'thumbnails'|@translate}"></a>
	{/if}
	
	{if isset($next)}
	<a class="navButton" href="{$next.U_IMG}" title="{'next_page'|@translate} : {$next.TITLE}" rel="next"><img src="{$ROOT_URL}{$themeconf.icon_dir}/right.png" class="button" alt="{'next_page'|@translate}"></a>
	{else}
	<a class="navButton"><img src="{$ROOT_URL}{$themeconf.icon_dir}/right_unactive.png" class="button" alt=""></a>
	{/if}
	
	{if isset($last)}
	<a class="navButton" href="{$last.U_IMG}" title="{'last_page'|@translate} : {$last.TITLE}" rel="last"><img src="{$ROOT_URL}{$themeconf.icon_dir}/last.png" class="button" alt="{'last_page'|@translate}"></a>
	{else}
	<a class="navButton"><img src="{$ROOT_URL}{$themeconf.icon_dir}/last_unactive.png" class="button" alt=""></a>
	{/if}
	
	{if isset($slideshow.U_START_REPEAT)}
	<a class="navButton" href="{$slideshow.U_START_REPEAT}" title="{'start_repeat'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/start_repeat.png" class="button" alt="{'start_repeat'|@translate}"></a>
	{/if}
	
	{if isset($slideshow.U_STOP_REPEAT)}
	<a class="navButton" href="{$slideshow.U_STOP_REPEAT}" title="{'stop_repeat'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/stop_repeat.png" class="button" alt="{'stop_repeat'|@translate}"></a>
	{/if}

</div>
