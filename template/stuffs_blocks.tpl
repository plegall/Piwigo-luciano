{foreach from=$blocks item=block key=key}
	<div id="stuffs_block_{$block.ID}" class="content">
	{if isset($block.TITLE)}
		<div class="titrePage">
			{if !empty($block.U_EDIT)}
			<ul class="categoryActions">
				<li><a href="{$block.U_EDIT}" title="{'edit'|@translate}"><img src="{$ROOT_URL}{$themeconf.icon_dir}/category_edit.png" class="button" alt="{'edit'|@translate}"/></a></li>
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
