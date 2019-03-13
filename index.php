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



if($_POST){

    if(isset($_POST['login'])){
        $required_fields = array('username', 'password');
        foreach($required_fields as $rf){
            if(empty($_POST[$rf]) || !isset($_POST[$rf])){
                $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_MISSING_FORM_INPUTS);
                $file = 'login.tpl';
            }
        }
        $valid = $bloghandler->checkLogin($_POST['username'], $_POST['password']);
        if($valid){
            $_SESSION['username'] = $_POST['username'];
            $user = $bloghandler->getUserInfoArray($_SESSION['username']);

            $file = 'blogpostlist.tpl';
            $notifications[] = array('type' => 'success', 'text' => TEXT_NOTIFICATION_LOGIN_SUCCESSFUL);
        }else{
            $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_LOGIN_FAILED);
            $file = 'login.tpl';
        }
    }
    if(isset($_POST['register'])){
        $ok = true;
        $required_fields = array('firstname', 'lastname', 'username', 'email', 'password', 'password2');
        foreach($required_fields as $rf){
            if(empty($_POST[$rf]) || !isset($_POST[$rf])){
                $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_MISSING_FORM_INPUTS);
                $ok = false;
                $file = 'register.tpl';
            }
        }
        if($ok) {
            $firstname = $_POST['firstname'];
            $lastname = $_POST['lastname'];
            $username = $_POST['username'];
            $password = $_POST['password'];
            $password2 = $_POST['password2'];
            $email = $_POST['email'];
            if (strlen($password) < 8) {
                $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_PASSWORD_LENGTH);
                $file = 'register.tpl';
            }

            if ($password === $password2) {
                $exists = $bloghandler->doesUserExist($username);
                if (!$exists) {
                    $bloghandler->addUser($username, $password, $email, $firstname, $lastname);
                    $_SESSION['username'] = $_POST['username'];
                    $user = $bloghandler->getUserInfoArray($_SESSION['username']);

                    $notifications[] = array('type' => 'success', 'text' => TEXT_NOTIFICATION_REGISTRATION_SUCCESSFUL);
                } else {
                    $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_USERNAME_TAKEN);
                    $file = 'register.tpl';
                }
            } else {
                $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_PASSWORDS_NOT_EQUAL);
                $file = 'register.tpl';
            }
        }
    }

    if(isset($_POST['admin__do'])){
        if($user['admin']) {
            switch ($_POST['admin__do']) {
                case 'togAdmin':
                    $userid = $_POST['admin__userID'];
                    $bloghandler->editUser($userid, 'admin', (($bloghandler->getUserByID($userid)['admin']) ? 0 : 1));
                    $notifications[] = array('type' => 'success', 'text' => TEXT_NOTIFICATION_USER_EDITED);
                    break;

                case 'togAuthor':
                    $userid = $_POST['admin__userID'];
                    $bloghandler->editUser($userid, 'isAuthor', (($bloghandler->getUserByID($userid)['isAuthor']) ? 0 : 1));
                    $notifications[] = array('type' => 'success', 'text' => TEXT_NOTIFICATION_USER_EDITED);
                    break;

                case 'deleteUser':
                    $userid = $_POST['admin__userID'];
                    break;

                case 'deleteBlogPost':
                    $blogid = $_POST['admin__blogID'];
                    $bloghandler->deleteBlog($blogid);
                    $notifications[] = array('type' => 'success', 'text' => TEXT_NOTIFICATION_BLOGPOST_DELETED);
                    break;

                case 'deleteComment':
                    $commentID = $_POST['admin__commentID'];
                    $bloghandler->deleteComment($commentID);
                    $notifications[] = array('type' => 'success', 'text' => TEXT_NOTIFICATION_COMMENT_DELETED);
                    break;

                case 'toggleBlogComments':
                    $blogid = $_POST['admin__blogID'];
                    $bloghandler->toggleBlogComments($blogid);
                    $notifications[] = array('type' => 'success', 'text' => TEXT_NOTIFICATION_COMMENTS_TOGGLED);
                    break;
            }
        }else{
            $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_NO_PERMISSIONS);
            $file = 'admin.tpl';
        }
    }

    if(isset($_POST['addBlogPost'])){
        //blog_text // blog_title
        $ok = true;
        $required_fields = array('blog_text', 'blog_title');
        foreach($required_fields as $rf){
            if(empty($_POST[$rf]) || !isset($_POST[$rf])){
                $ok = false;
                $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_MISSING_FORM_INPUTS);
                $file = 'newblog.tpl';
            }
        }
        if($ok) {
            $bloghandler->addBlog($_POST['blog_title'], $user['id'], base64_decode($_POST['blog_text']), 1);
            $notifications[] = array('type' => 'success', 'text' => TEXT_NOTIFICATION_BLOGPOST_PUBLISHED);
        }
    }

    if(isset($_POST['addComment'])){
        $ok = true;
        $required_fields = array('comment_text', 'comment_blogid');
        foreach($required_fields as $rf){
            if(empty($_POST[$rf]) || !isset($_POST[$rf])){
                $ok = false;
                $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_MISSING_FORM_INPUTS);
                $file = 'blogpost.tpl';
            }
        }
        if($ok) {
            $bloghandler->addComment($_POST['comment_blogid'], $user['id'], $_POST['comment_text']);
            $notifications[] = array('type' => 'success', 'text' => TEXT_NOTIFICATION_COMMENT_PUBLISHED);
        }
    }


}


if(isset($_SESSION['username'])){
    $user = $bloghandler->getUserInfoArray($_SESSION['username']);
}







$page = ((isset($_GET['p'])) ? $_GET['p'] : '');
switch($page){
    case 'blog':
        $id = ((isset($_GET['id'])) ? $_GET['id'] : 0);
        $blogpost = $bloghandler->getBlogPost($id);
        if($blogpost){
            $data['blogpost'] = $blogpost;
            $data['comments'] = $bloghandler->getBlogComments($id);
            $file = 'blogpost.tpl';
        }else{
            $notifications[] = array('type' => 'warning', 'text' => TEXT_NOTIFICATION_BLOGPOST_NOT_FOUND);
            $file = 'blogpostlist.tpl';
        }
        break;

    case 'login':
        $file = 'login.tpl';
        break;

    case 'register':
        $file = 'register.tpl';
        break;

    case 'logout':
        unset($_SESSION['username']);
        $user = array('loggedin' => false, 'admin' => 0, 'isAuthor' => 0);
        $notifications[] = array('type' => 'success', 'text' => TEXT_NOTIFICATION_LOGGED_OUT);
        break;

    case 'admin':
        if($user['admin']){
            $file = 'admin.tpl';
            $data['users'] = $bloghandler->getUsers();
            $data['constants'] = get_defined_constants(true)['user'];
        }else{
            $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_NO_PERMISSIONS);
        }
        break;

    case 'createBlogPost':
        if($user['isAuthor']) {
            $file = 'newblog.tpl';
        }else{
            $notifications[] = array('type' => 'danger', 'text' => TEXT_NOTIFICATION_NO_PERMISSIONS);
        }
        break;

    case 'search':
        $query = ((isset($_GET['query'])) ? $_GET['query'] : '');
        $blog_entries = $bloghandler->searchBlogs($query);
        if(!$blog_entries){
            $notifications[] = array('type' => 'warning', 'text' => TEXT_NOTIFICATION_NO_SEARCH_RESULT);
        }
        $file = 'search.tpl';
        $data['search_items'] = $blog_entries;
        $data['search_query'] = $query;
        break;

    default:
        break;
}



if($file == 'blogpostlist.tpl'){
    $data['blog_entries'] = $bloghandler->getBlogEntries();
}
$data['user'] = $user;
$data['notifications'] = $notifications;

$bloghandler->loadPage($file, $data);