<div class="navigationBarSimple">
{if isset($navbar.URL_PREV)}
  <a class="prew" href="{$navbar.URL_PREV}" rel="prev">&gt;</a>
{/if}
{if isset($navbar.URL_NEXT)}
  <a class="next" href="{$navbar.URL_NEXT}" rel="next">&gt;</a>
{/if}
</div>

<div class="navigationBar">
  {if isset($navbar.URL_FIRST)}
    <a href="{$navbar.URL_FIRST}" rel="first">&lt;&lt;</a>
    <a href="{$navbar.URL_PREV}" rel="prev">&lt;</a>
  {else}
    <span>&lt;&lt;</span>
    <span>&lt;</span>
  {/if}

  {assign var='prev_page' value=0}
  {foreach from=$navbar.pages key=page item=url}
    {if $page > $prev_page+1}...{/if}
    {if $page == $navbar.CURRENT_PAGE}
      <span class="pageNumberSelected">{$page}</span>
    {else}
      <a href="{$url}">{$page}</a>
    {/if}
    {assign var='prev_page' value=$page}
  {/foreach}

  {if isset($navbar.URL_NEXT)}
    <a href="{$navbar.URL_NEXT}" rel="next">&gt;</a>
    <a href="{$navbar.URL_LAST}" rel="last">&gt;&gt;</a>
  {else}
    <span>&gt;&gt;</span>
    <span>&gt;</span>
  {/if}
</div>
