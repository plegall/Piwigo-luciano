{if !empty($PLUGIN_PICTURE_BEFORE)}{$PLUGIN_PICTURE_BEFORE}{/if}
<div id="imageHeaderBar">
    <div class="browsePath">
      {$SECTION_TITLE}
      {$LEVEL_SEPARATOR}{$current.TITLE}
    </div>
  <div class="imageNumber">{$PHOTO}</div>
  <ul class="randomButtons">
    {if isset($U_SLIDESHOW_START)		}<li><a href="{$U_SLIDESHOW_START}" title="{'slideshow'|@translate}" id="bn-slideshowPlay" rel="nofollow">{'slideshow'|@translate}</a></li>{/if}
    {if isset($U_SLIDESHOW_STOP)		}<li><a href="{$U_SLIDESHOW_STOP}" title="{'slideshow_stop'|@translate}" id="bn-slideshowStop" rel="nofollow">{'slideshow_stop'|@translate}</a></li>{/if}
    {if isset($PLUGIN_PICTURE_ACTIONS)	}<li>{$PLUGIN_PICTURE_ACTIONS}</li>{/if}
    {if isset($favorite)				}<li><a href="{$favorite.U_FAVORITE}" title="{$favorite.FAVORITE_HINT}" id="bn-favourite">{$favorite.FAVORITE_HINT}</a></li>{/if}
    {if !empty($U_SET_AS_REPRESENTATIVE)}<li><a href="{$U_SET_AS_REPRESENTATIVE}" title="{'set as category representative'|@translate}" id="bn-higlight">{'representative'|@translate}</a></li>{/if}
    {if isset($U_ADMIN)					}<li><a href="{$U_ADMIN}" title="{'link_info_image'|@translate}" id="bn-edit">{'edit'|@translate}</a></li>{/if}
    {if isset($U_CADDIE)				}
                      <script type="text/javascript">{literal}function addToCadie(aElement, rootUrl, id){if (aElement.disabled) return;aElement.disabled=true;var y=new PwgWS(rootUrl);y.callService("pwg.caddie.add",{image_id: id},{onFailure:function(num,text){alert(num+" "+text);document.location=aElement.href;},onSuccess:function(result){aElement.disabled=false;}});}{/literal}</script>
                      <li><a href="{$U_CADDIE}" onclick="addToCadie(this, '{$ROOT_URL|@escape:'javascript'}', {$current.id}); return false;" title="{'add to caddie'|@translate}" id="bn-caddie">{'caddie'|@translate}</a></li>
    {/if}
  </ul>
</div>

<div id="theImage">
  <div id="imageContainer">
    {if isset($previous) }<a class="navThumb" id="linkPrev" href="{$previous.U_IMG}" title="{'previous_page'|@translate} : {$previous.TITLE}" rel="prev"><img src="{$previous.THUMB_SRC}" alt="{$previous.TITLE}" /></a>{/if}
    {if isset($next) }<a class="navThumb" id="linkNext" href="{$next.U_IMG}" title="{'next_page'|@translate} : {$next.TITLE}" rel="next"><img src="{$next.THUMB_SRC}" alt="{$next.TITLE}" /></a>{/if}
    <div id="theImg">{$ELEMENT_CONTENT}</div>
  </div>
  {if isset($U_SLIDESHOW_STOP) }<p>[ <a href="{$U_SLIDESHOW_STOP}">{'slideshow_stop'|@translate}</a>]</p>{/if}
</div>

<div id="imageInfo">
  <div id="imageInfoLeft">
    <div id="viewRatign"><span class="viewTxt">{'Visits'|@translate} </span><span class="viewValue">{$INFO_VISITS}</span></div>
    {if isset($related_tags)}
    <div id="imageTags"><span class="tagTxt">{'Tags'|@translate}: </span><span class="tagValue">{foreach from=$related_tags item=tag name=tag_loop}{if !$smarty.foreach.tag_loop.first}, {/if}<a href="{$tag.URL}">{$tag.name}</a>{/foreach}</span></div>
    {/if}
  </div>

  {if $display_info.average_rate and isset($rate_summary) }
  <div id="imageInfoRight">
    <div class="value" id="ratingSummary">
        {'Average rate'|@translate}:
		  	{assign var='rate_text' value='%.2f (rated %d times)'|@translate }
		  	{$pwg->sprintf($rate_text, $rate_summary.average, $rate_summary.count) }
    </div>
    
    {if isset($rating)}
    <form action="{$rating.F_ACTION}" method="post" id="rateForm">
      <div>
      {assign var="ratingExploded" value=$rate_summary.average|@explode:'.'}
      {foreach from=$rating.marks item=mark name=rate_loop}
        {if !$smarty.foreach.rate_loop.first} | {/if}
        
        <input type="{if isset($rating.USER_RATE) && $mark==$rating.USER_RATE}button{else}submit{/if}" name="rate" value="{$mark}" class="
        {if $smarty.foreach.rate_loop.first} rateButtonReset
        {elseif $mark<=$rating.USER_RATE} 
            rateButtonUser{if $mark<=$ratingExploded[0]}Full{elseif $mark==$ratingExploded[0]+1 && $ratingExploded[1]>49}Half{else}Empty{/if}
          {elseif $mark<=$ratingExploded[0]} rateButtonFull
          {elseif $mark==$ratingExploded[0]+1 && $ratingExploded[1]>49} rateButtonHalf
        {else}
        rateButtonEmpty
        {/if}
        
        " title="{$mark}" />
        {/foreach}
        <script type="text/javascript">
	  		makeNiceRatingForm( {ldelim}rootUrl: '{$ROOT_URL|@escape:"javascript"}', image_id: {$current.id},
	  		  ratingSummaryText: "{'Average rate'|@translate}: {'%.2f (rated %d times)'|@translate|@escape:'javascript'}",
          ratingSummaryElement: document.getElementById("ratingSummary") {rdelim} );
	  		</script>
      </div>
    </form>
    {else}
    <div class="rateShow">
      {assign var="ratingExploded" value=$rate_summary.average|@explode:'.'}
      <span class="rateFull{$ratingExploded[0]}"></span>{if $ratingExploded[1]>49}<span class="rateHalf"></span>{/if}
    </div>
    {/if}
  </div>
  {/if}
  <div class="clear"></div>
</div>
{if !empty($PLUGIN_PICTURE_AFTER)}{$PLUGIN_PICTURE_AFTER}{/if}