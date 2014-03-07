{foreach from=$blocks item=block key=key}
	<div id="stuffs_block_{$block.ID}" class="content contentWithMenu">
	{if isset($block.TITLE)}
		<div class="titrePage">
			{if !empty($block.U_EDIT)}
			<ul class="categoryActions">
				<li><a href="{$block.U_EDIT}" title="{'edit'|@translate}"><span class="pwg-icon pwg-icon-category-edit"> </span><span class="pwg-button-text">{'edit'|@translate}</span></a></li>
			</ul>
			{/if}
		{if isset($block.TITLE_URL)}
		<h2><a href="{$block.TITLE_URL}">{$block.TITLE}</a></h2>
		{else}
		<h2>{$block.TITLE}</h2>
		{/if}
		</div>
	{/if}
	{include file=$block.TEMPLATE}
	</div>
{/foreach}
