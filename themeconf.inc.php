<?php
/*
Theme Name: Luciano Amodio
Version: 2.1.a
Description: Luciano Amodio's theme
Theme URI: http://piwigo.org/ext/extension_view.php?eid=387
Author: Luciano Amodio & P@t
Author URI: http://www.lucianoamodio.it/portfolio/
*/

$themeconf = array(
  'icon_dir'    => 'themes/luciano/icon',
  'local_head'  => 'local_head.tpl',
);

$this->set_template_dir(PHPWG_THEMES_PATH.'default/template');
$this->smarty->register_prefilter( 'add_footer_and_clear_div' );

$conf['show_thumbnail_caption'] = false;

function add_footer_and_clear_div($content, &$smarty)
{
  return
    str_replace(
      '</div> <!-- content -->',
      "<div class=\"footer\"></div>\n</div> <!-- content -->\n<div class=\"clear\"></div>",
      $content
    );
}

// Remove comments link in Menu
add_event_handler('blockmanager_apply' , 'remove_comments_link');
function remove_comments_link($menu_ref_arr)
{
  $menu = & $menu_ref_arr[0];
  if (($block = $menu->get_block('mbMenu')) != null )
    unset($block->data['comments']);
}

global $user;

$user['nb_image_line'] = 4;
$user['nb_line_page'] = 3;
$user['nb_image_page'] = 12;
$user['maxwidth'] = 800;
$user['maxheight'] = 600;

?>
