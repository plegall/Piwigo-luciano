<!--[if lt IE 8]>
	<link rel="stylesheet" type="text/css" href="{$ROOT_URL}themes/luciano/fix-ie7.css">
<![endif]-->
<!--[if lt IE 7]>
	<link rel="stylesheet" type="text/css" href="{$ROOT_URL}themes/luciano/fix-ie6.css">
<![endif]-->

{if $BODY_ID == 'thePicturePage'}
<style type="text/css">
#theImage #theImg img {ldelim}
  margin-top:{math equation="(600-y)/2" y=$HEIGHT_IMG format="%d"}px;
}
</style>
{/if}

{*
{combine_script id="mootools.core" path="themes/luciano/js/mootools-1.2.4-core.js"}
{combine_script id="mootools.more" require="mootools.core" path="themes/luciano/js/mootools-1.2.4.4-more.js"}
*}
{combine_script id="luciano.script" path="themes/luciano/js/script.js"}

{footer_script}
if (typeof jQuery != 'undefined') {ldelim} jQuery.noConflict();}
{/footer_script}