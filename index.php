<?php session_start();
require_once 'handler.php';
$bloghandler = new BlogHandler();
$admin = false;
if(isset($_GET['admin'])){
    $admin = true;
}
$user = array('loggedin' => false, 'admin' => 0);
if(isset($_SESSION['username'])){
    $ui = $bloghandler->getUser($_SESSION['username']);
    $user = array();
    $user['loggedin'] = true;
    $user['username'] = $_SESSION['username'];
    $user['admin'] = $ui['admin'];
    $user['firstname'] = $ui['firstname'];
    $user['lastname'] = $ui['lastname'];
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
            $bloghandler->addComment($_POST['comment_blogid'], $user['firstname'].' '.$user['lastname'], $_POST['comment_text']);
        }

        $blogpost = $bloghandler->getBlogPost($_POST['comment_blogid']);
        $comments = $bloghandler->getBlogComments($_POST['comment_blogid']);
        $bloghandler->loadPage('blogpost.tpl', array('blogpost' => $blogpost, 'notifications' => $notifications, 'comments' => $comments, 'user' => $user));
    }else if(isset($_POST['login'])){
        $required_fields = array('username', 'password');
        foreach($required_fields as $rf){
            if(empty($_POST[$rf]) || !isset($_POST[$rf])){
                $notifications[] = array('type' => 'danger', 'text' => "Es müssen alle Felder ausgefüllt werden.");
                $bloghandler->loadPage('login.tpl', array('notifications' => $notifications, 'user' => $user));
                die();
            }
        }
        $valid = $bloghandler->checkLogin($_POST['username'], $_POST['password']);
        if($valid){
            $_SESSION['username'] = $_POST['username'];
            Header('Location: index.php');
            die();
        }else{
            $notifications[] = array('type' => 'danger', 'text' => "Das hat nicht geklappt. Bitte überprüfe Deine Eingaben.");
            $bloghandler->loadPage('login.tpl', array('notifications' => $notifications, 'user' => $user));
            die();
        }
    }else if(isset($_POST['register'])){
        $required_fields = array('firstname', 'lastname', 'username', 'email', 'password', 'password2');
        foreach($required_fields as $rf){
            if(empty($_POST[$rf]) || !isset($_POST[$rf])){
                $notifications[] = array('type' => 'danger', 'text' => "Es müssen alle Felder ausgefüllt werden.");
                $bloghandler->loadPage('register.tpl', array('notifications' => $notifications, 'user' => $user));
                die();
            }
        }
        $firstname = $_POST['firstname'];
        $lastname = $_POST['lastname'];
        $username = $_POST['username'];
        $password = $_POST['password'];
        $password2 = $_POST['password2'];
        $email = $_POST['email'];

        if($password === $password2) {
            $exists = $bloghandler->doesUserExist($username);
            if (!$exists) {
                $bloghandler->addUser($username, $password, $email, $firstname, $lastname);
                $_SESSION['username'] = $username;
                Header('Location: index.php');
                die();
            } else {
                $notifications[] = array('type' => 'danger', 'text' => "Ein Nutzer mit dem Namen <i>" . $username . "</i> existiert bereits.");
                $bloghandler->loadPage('register.tpl', array('notifications' => $notifications, 'user' => $user));
                die();
            }
        }else{
            $notifications[] = array('type' => 'danger', 'text' => "Die eingegebenen Passwörter stimmen nicht überein.");
            $bloghandler->loadPage('register.tpl', array('notifications' => $notifications, 'user' => $user));
            die();
        }
    }
    die();
}

if(isset($_GET['search'])){
    $blog_entries = $bloghandler->searchBlogs($_GET['search']);
    if(!$blog_entries){
        $notifications[] = array('type' => 'warning', 'text' => "Es konnte kein Blogeintrag mit dem Suchbegriff '".$_GET['search']."' gefunden werden.");
    }

    $bloghandler->loadPage('search.tpl', array('search_items' => $blog_entries, 'search_query' => $_GET['search'], 'notifications' => $notifications, 'user' => $user));
    die();
}
if(isset($_GET['login'])){
    $bloghandler->loadPage('login.tpl', array('notifications' => $notifications, 'user' => $user));
    die();
}
if(isset($_GET['register'])){
    $bloghandler->loadPage('register.tpl', array('notifications' => $notifications, 'user' => $user));
    die();
}
if(isset($_GET['logout'])){
    $user = array('loggedin' => false, 'admin' => 0);
    unset($_SESSION['username']);
    $notifications[] = array('type' => 'success', 'text' => "Du wurdest erfolgreich abgemeldet.");
    $bloghandler->loadPage('login.tpl', array('notifications' => $notifications, 'user' => $user));
    die();
}
if(isset($_GET['id'])){
    $id = $_GET['id'];

    $blogpost = $bloghandler->getBlogPost($id);
    if(!$blogpost){
        $blog_entries = $bloghandler->getBlogEntries();
        $notifications[] = array('type' => 'warning', 'text' => "Der angeforderte Blogeintrag konnte nicht gefunden werden.");
        $bloghandler->loadPage('blogpostlist.tpl', array('blog_entries' => $blog_entries, 'notifications' => $notifications, 'user' => $user));
    }else{
        $comments = $bloghandler->getBlogComments($id);
        $bloghandler->loadPage('blogpost.tpl', array('blogpost' => $blogpost, 'notifications' => $notifications, 'comments' => $comments, 'user' => $user));
    }
}else{
    $blog_entries = $bloghandler->getBlogEntries();
    $bloghandler->loadPage('blogpostlist.tpl', array('notifications' => $notifications, 'blog_entries' => $blog_entries, 'user' => $user));
}

