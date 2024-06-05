<!--[if lt IE 8]>
	<link rel="stylesheet" type="text/css" href="{$ROOT_URL}themes/luciano/fix-ie7.css">
<![endif]-->
<!--[if lt IE 7]>
	<link rel="stylesheet" type="text/css" href="{$ROOT_URL}themes/luciano/fix-ie6.css">
<![endif]-->

{combine_script id="luciano.script" path="themes/luciano/js/script.js"}

{combine_script id='jquery.chosen' load='footer' path='themes/default/js/plugins/chosen.jquery.min.js'}
{combine_css path="themes/default/js/plugins/chosen.css"}

{footer_script require='jquery'}{literal}
jQuery(document).ready(function() {
  jQuery("select[name=theme], select[name=language]").chosen();
});
{/literal}{/footer_script}