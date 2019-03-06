<?php
require_once 'handler.php';
$bloghandler = new BlogHandler();
$admin = false;
if(isset($_GET['admin'])){
    $admin = true;
}

$notifications = array();
if($_POST){
    if(isset($_POST['comment_text'])){
        if(strpos($_POST['comment_text'], '<script>') !== FALSE){
            $notifications[] = array('type' => 'warning', 'text' => "Der Kommentar wurde nicht gesendet, der er unerlaubten Text enthielt.");
        }else if(!$bloghandler->commentsAllowed($_POST['comment_blogid'])){
            $notifications[] = array('type' => 'warning', 'text' => "Der Kommentar wurde nicht gesendet, da Kommentare für den gewählten Blogeintrag deaktiviert sind.");
        }else {
            $notifications[] = array('type' => 'success', 'text' => "Der Kommentar wurde erfolgreich veröffentlicht.");
            $bloghandler->addComment($_POST['comment_blogid'], $_POST['comment_name'], $_POST['comment_text']);
        }

        $blogpost = $bloghandler->getBlogPost($_POST['comment_blogid']);
        $comments = $bloghandler->getBlogComments($_POST['comment_blogid']);
        $bloghandler->loadPage('blogpost.tpl', array('blogpost' => $blogpost, 'notifications' => $notifications, 'comments' => $comments, 'admin' => $admin));
    }
    die();
}

if(isset($_GET['search'])){
    $blog_entries = $bloghandler->searchBlogs($_GET['search']);
    if(!$blog_entries){
        $notifications[] = array('type' => 'warning', 'text' => "Es konnte kein Blogeintrag mit dem Suchbegriff '".$_GET['search']."' gefunden werden.");
    }

    $bloghandler->loadPage('search.tpl', array('search_items' => $blog_entries, 'search_query' => $_GET['search'], 'notifications' => $notifications, 'admin' => $admin));
    die();
}
if(isset($_GET['id'])){
    $id = $_GET['id'];

    $blogpost = $bloghandler->getBlogPost($id);
    if(!$blogpost){
        $blog_entries = $bloghandler->getBlogEntries();
        $notifications[] = array('type' => 'warning', 'text' => "Der angeforderte Blogeintrag konnte nicht gefunden werden.");
        $bloghandler->loadPage('blogpostlist.tpl', array('blog_entries' => $blog_entries, 'notifications' => $notifications, 'admin' => $admin));
    }else{
        $comments = $bloghandler->getBlogComments($id);
        $bloghandler->loadPage('blogpost.tpl', array('blogpost' => $blogpost, 'notifications' => $notifications, 'comments' => $comments, 'admin' => $admin));
    }
}else{
    $blog_entries = $bloghandler->getBlogEntries();
    $bloghandler->loadPage('blogpostlist.tpl', array('notifications' => $notifications, 'blog_entries' => $blog_entries, 'admin' => $admin));
}

