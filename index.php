<?php
require_once 'handler.php';
$bloghandler = new BlogHandler();

if($_POST){
    if(isset($_POST['comment_text'])){
        $bloghandler->addComment($_POST['comment_blogid'], $_POST['comment_name'], $_POST['comment_text']);

        $blogpost = $bloghandler->getBlogPost($_POST['comment_blogid']);
        $comments = $bloghandler->getBlogComments($_POST['comment_blogid']);
        $bloghandler->loadPage('blogpost.tpl', array('blogpost' => $blogpost, 'added_comment' => true, 'comments' => $comments));
    }
    die();
}

if(isset($_GET['id'])){
    $id = $_GET['id'];

    $blogpost = $bloghandler->getBlogPost($id);
    if(!$blogpost){
        $blog_entries = $bloghandler->getBlogEntries();
        $bloghandler->loadPage('blogpostlist.tpl', array('notfound' => true, 'blog_entries' => $blog_entries));
    }else{
        $comments = $bloghandler->getBlogComments($id);
        $bloghandler->loadPage('blogpost.tpl', array('blogpost' => $blogpost, 'added_comment' => false, 'comments' => $comments));
    }
}else{
    $blog_entries = $bloghandler->getBlogEntries();
    $bloghandler->loadPage('blogpostlist.tpl', array('notfound' => false, 'blog_entries' => $blog_entries));
}

