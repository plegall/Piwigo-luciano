<form method="post" name="profile" action="{$F_ACTION}" id="profile" class="properties">

  <fieldset>
    <legend>{'Registration'|@translate}</legend>
    <input type="hidden" name="redirect" value="{$REDIRECT}">
    <ul>
      <li>
        <span class="property">{'Username'|@translate}</span>
        {$USERNAME}
      </li>
{if not $SPECIAL_USER} {* can modify password + email*}
      <li>
        <span class="property">
          <label for="mail_address">{'Email address'|@translate}</label>
        </span>
        <input type="text" name="mail_address" id="mail_address" value="{$EMAIL}">
      </li>
{if not $IN_ADMIN} {* admins do not need old password*}
      <li>
        <span class="property">
          <label for="password">{'Password'|@translate}</label>
        </span>
        <input type="password" name="password" id="password" value="">
      </li>
{/if}
      <li>
        <span class="property">
          <label for="use_new_pwd">{'New password'|@translate}</label>
        </span>
        <input type="password" name="use_new_pwd" id="use_new_pwd" value="">
      </li>
      <li>
        <span class="property">
          <label for="passwordConf">{'Confirm Password'|@translate}</label>
        </span>
        <input type="password" name="passwordConf" id="passwordConf" value="">
      </li>
    </ul>
{/if}
  </fieldset>

{if $ALLOW_USER_CUSTOMIZATION}
  <fieldset>
    <legend>{'Preferences'|@translate}</legend>

    <ul>
      <li>
        <span class="property">
          <label for="template">{'Interface theme'|@translate}</label>
        </span>
        <div id="themeSelect">
        {html_options name=theme options=$template_options selected=$template_selection}
        </div>
      </li>
      <li>
        <span class="property">
          <label for="Language">{'Language'|@translate}</label>
        </span>
        <div id="languageSelect">
        {html_options name=language options=$language_options selected=$language_selection}
        </div>
      </li>
      <li>
        <span class="property">
          <label for="Recent period">{'Recent period'|@translate}</label>
        </span>
        <input type="text" size="3" maxlength="2" name="recent_period" id="recent_period" value="{$RECENT_PERIOD}">
      </li>
      <li>
        <span class="property">
          <label for="Expand all categories">{'Expand all categories'|@translate}</label>
        </span>
        {foreach from=$radio_options key=value item=option}
          <input type="radio" name="expand" value="{$value}" {if $value==$EXPAND}checked="checked"{/if}>{$option}
        {/foreach}

      </li>
    </ul>
  </fieldset>
{/if}

  <p class="bottomButtons">
    <input type="hidden" name="pwg_token" value="{$PWG_TOKEN}">
    <input type="hidden" name="nb_image_line" id="nb_image_line" value="{$NB_IMAGE_LINE}">
    <input type="hidden" name="nb_line_page" id="nb_line_page" value="{$NB_ROW_PAGE}" >
    <input type="hidden" name="show_nb_comments" id="show_nb_comments" value="{$NB_COMMENTS}" >
    <input type="hidden" name="show_nb_hits" id="show_nb_hits" value="{$NB_HITS}" >
    <input type="hidden" name="maxwidth" id="maxwidth" value="{$MAXWIDTH}">
    <input type="hidden" name="maxheight" id="maxheight" value="{$MAXHEIGHT}">

    <input class="submit" type="submit" name="validate" value="{'Submit'|@translate}">
    <input class="submit" type="reset" name="reset" value="{'Reset'|@translate}">
    {if $ALLOW_USER_CUSTOMIZATION}
    <input class="submit" type="submit" name="reset_to_default" value="{'Reset to default values'|@translate}">
    {/if}
  </p>

</form>
