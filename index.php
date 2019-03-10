<?php session_start();
require_once 'configs/de.lang.php';
require_once 'handler.php';
$bloghandler = new BlogHandler();

$data = array();
$notifications = array();
$file = 'blogpostlist.tpl';



$user = array('loggedin' => false, 'admin' => 0, 'isAuthor' => 0);
if(isset($_SESSION['username'])){
    $user = $bloghandler->getUserInfoArray($_SESSION['username']);
}

$page = ((isset($_GET['p'])) ? $_GET['p'] : '');
switch($page){
    case 'login':
        $file = 'login.tpl';
        break;

    case 'register':
        $file = 'register.tpl';
        break;

    case 'logout':
        unset($_SESSION['username']);
        $user = array('loggedin' => false, 'admin' => 0);
        $notifications[] = array('type' => 'success', 'text' => TEXT_NOTIFICATION_LOGGED_OUT);
        $file = 'blogpostlist.tpl';
        $data['blog_entries'] = $bloghandler->getBlogEntries();
        break;

    case 'admin':
        if($user['admin']){
            $file = 'admin.tpl';
            $data['users'] = $bloghandler->getUsers();
        }else{
            $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_NO_PERMISSIONS);
            $file = 'blogpostlist.tpl';
            $data['blog_entries'] = $bloghandler->getBlogEntries();
        }
        break;

    case 'createBlogPost':
        if($user['isAuthor']) {
            $file = 'newblog.tpl';
        }else{
            $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_NO_PERMISSIONS);
            $file = 'blogpostlist.tpl';
            $data['blog_entries'] = $bloghandler->getBlogEntries();
        }
        break;

    default:
        $file = 'blogpostlist.tpl';
        $data['blog_entries'] = $bloghandler->getBlogEntries();
        break;
}


$data['user'] = $user;
$data['notifications'] = $notifications;

$bloghandler->loadPage($file, $data);