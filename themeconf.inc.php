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
  'parent'                 => 'default',
  'icon_dir'               => 'themes/luciano/icon',
  'local_head'             => 'local_head.tpl',
  'load_parent_css'        => false,
  'load_parent_local_head' => false,
);

$conf['show_thumbnail_caption']  = false;
$conf['index_posted_date_icon']  = false;
$conf['index_created_date_icon'] = false;
$conf['top_number'] = 12;

// Remove comments and calendar links in menubar
add_event_handler('blockmanager_apply' , 'remove_comments_and_calendar_links');
function remove_comments_and_calendar_links($menu_ref_arr)
{
  $menu = & $menu_ref_arr[0];
  if (($block = $menu->get_block('mbMenu')) != null )
    unset($block->data['comments']);
  if (($block = $menu->get_block('mbSpecials')) != null )
    unset($block->data['calendar']);
}

global $user;

$user['nb_image_line'] = 4;
$user['nb_line_page'] = 3;
$user['nb_image_page'] = 12;
$user['maxwidth'] = 800;
$user['maxheight'] = 600;

?>