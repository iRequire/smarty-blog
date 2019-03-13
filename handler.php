<?php
require('configs/config.php');
require(SMARTYPATH.'/Smarty.class.php');
class BlogHandler {

    public $smarty;
    public $pdo;

    public function __construct()
    {
        set_error_handler(array($this, "customErrorHandler"));


        $smarty = new Smarty;
        $smarty->template_dir = 'templates';
        $smarty->config_dir = 'config';
        $smarty->cache_dir = SMARTYPATH.'/cache';
        $smarty->compile_dir = SMARTYPATH.'/templates_c';
        $smarty->default_modifiers = array('escape:"html"');
        $this->smarty = $smarty;

        $pdo = new PDO('mysql:host='.DBHOST.';dbname='.DBNAME.';charset=utf8', DBUSER, DBPASS);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_WARNING);
        $this->pdo = $pdo;
    }

    public function loadPage($template, $data){
        $this->smarty->assign("data", $data);

        $this->smarty->display($template);
    }

    public function getBlogPost($id){
        $stmt = $this->pdo->prepare("SELECT * FROM blog_entries WHERE id=? LIMIT 1");
        $stmt->execute(array($id));
        $row = $stmt->fetch();
        $rowcount = $stmt->rowCount();

        if($rowcount > 0){ $row['author_name'] = self::getFullNameByID($row['author']); }

        return (($rowcount > 0) ? $row : false);
    }

    public function getBlogEntries(){
        $blog_entries = array();
        $statement = $this->pdo->prepare("SELECT * FROM blog_entries ORDER BY id DESC");
        $statement->execute();
        while($row = $statement->fetch()) {
            $row['author_name'] = self::getFullNameByID($row['author']);
            $blog_entries[] = $row;
        }

        return $blog_entries;
    }

    public function getBlogComments($blog_id){
        $comments = array();
        $statement = $this->pdo->prepare("SELECT * FROM blog_comments WHERE `blogid` = ? ORDER BY id DESC");
        $statement->execute(array($blog_id));
        while($row = $statement->fetch()) {
            $row['author_name'] = self::getFullNameByID($row['name']);
            $comments[] = $row;
        }

        return $comments;
    }

    public function searchBlogs($search_query){
        $blog_entries = array();
        $count = 0;


        $statement = $this->pdo->prepare("SELECT * FROM blog_entries WHERE title LIKE ?");
        $statement->execute(array('%'.$search_query.'%'));
        while($row = $statement->fetch()) {
            $row['author_name'] = self::getFullNameByID($row['author']);
            $blog_entries[] = $row;
        }
        $count += $statement->rowCount();

        $statement = $this->pdo->prepare("SELECT * FROM blog_entries WHERE author LIKE ?");
        $statement->execute(array('%'.$search_query.'%'));
        while($row = $statement->fetch()) {
            $row['author_name'] = self::getFullNameByID($row['author']);
            $blog_entries[] = $row;
        }
        $count += $statement->rowCount();

        $statement = $this->pdo->prepare("SELECT * FROM blog_entries WHERE text LIKE ?");
        $statement->execute(array('%'.$search_query.'%'));
        while($row = $statement->fetch()) {
            $row['author_name'] = self::getFullNameByID($row['author']);
            $blog_entries[] = $row;
        }
        $count += $statement->rowCount();

        $blog_entries_unique = self::unique_multidim_array($blog_entries, 'title');

        return (($count > 0) ? $blog_entries_unique : false);
    }

    public function commentsAllowed($blog_id){
        $stmt = $this->pdo->prepare("SELECT * FROM blog_entries WHERE id = ? LIMIT 1");
        $stmt->execute(array($blog_id));
        $row = $stmt->fetch();

        return $row['enable_comments'];
    }

    public function addComment($blog_id, $user_id, $text){
        $statement = $this->pdo->prepare("INSERT INTO blog_comments (blogid, name, text) VALUES (?, ?, ?)");
        $statement->execute(array($blog_id, $user_id, $text));
    }

    public function doesUserExist($username){
        $stmt = $this->pdo->prepare("SELECT * FROM blog_users WHERE username = ? LIMIT 1");
        $stmt->execute(array($username));
        $stmt->fetch();

        return (($stmt->rowCount() == 0) ? false : true);
    }

    public function addUser($username, $password, $email, $firstname, $lastname){
        $statement = $this->pdo->prepare("INSERT INTO blog_users (username, password, email, firstname, lastname, admin) VALUES (?, ?, ?, ?, ?, ?)");
        $password = hash_hmac('sha512', $password, $username); // Passwort mit Username hashen
        $statement->execute(array($username, $password, $email, $firstname, $lastname, 0));
    }

    public function checkLogin($username, $password){
        $stmt = $this->pdo->prepare("SELECT * FROM blog_users WHERE username = ? LIMIT 1");
        $stmt->execute(array($username));
        $row = $stmt->fetch();

        $entered_pw = hash_hmac('sha512', $password, $username);
        if($row['password'] === $entered_pw){
            return true;
        }else{
            return false;
        }
    }

    public function getUser($username){
        $stmt = $this->pdo->prepare("SELECT * FROM blog_users WHERE username = ? LIMIT 1");
        $stmt->execute(array($username));
        return $stmt->fetch();
    }

    public function getUserByID($id){
        $stmt = $this->pdo->prepare("SELECT * FROM blog_users WHERE id = ? LIMIT 1");
        $stmt->execute(array($id));
        return $stmt->fetch();
    }

    public function getUsernameByID($id){
        return self::getUserByID($id)['username'];
    }

    public function getUserIDByName($name){
        return self::getUser($name)['id'];
    }

    public function getFullNameByID($id){
        $usr = self::getUserByID($id);
        return $usr['firstname'].' '.$usr['lastname'];
    }

    public function addBlog($title, $author_id, $text, $enable_comments){
        $statement = $this->pdo->prepare("INSERT INTO blog_entries (title, author, text, enable_comments) VALUES (?, ?, ?, ?)");
        $statement->execute(array($title, $author_id, $text, $enable_comments));
    }

    public function deleteBlog($id){
        $statement = $this->pdo->prepare('DELETE FROM blog_entries WHERE id = ?');
        $statement->execute(array($id));
    }

    public function getUserInfoArray($username){
        $ui = self::getUser($username);
        $user = array();
        $user['loggedin'] = true;
        $user['id'] = $ui['id'];
        $user['username'] = $username;
        $user['admin'] = $ui['admin'];
        $user['firstname'] = $ui['firstname'];
        $user['lastname'] = $ui['lastname'];
        $user['isAuthor'] = $ui['isAuthor'];
        $user['register_date'] = $ui['register_date'];

        return $user;
    }

    public function getUsers(){
        $users = array();
        $statement = $this->pdo->prepare("SELECT * FROM blog_users ORDER BY id ASC");
        $statement->execute();
        while($row = $statement->fetch()) {
            $users[] = $row;
        }

        return $users;
    }

    public function editUser($id, $type, $value){
        $statement = $this->pdo->prepare("UPDATE blog_users SET `".$type."` = ? WHERE id = ?");
        $statement->execute(array($value, $id));
    }

    public function deleteUser($id){
        $statement = $this->pdo->prepare("DELETE FROM blog_users WHERE id = ?");
        $statement->execute(array($id));
    }

    public function deleteComment($id){
        $statement = $this->pdo->prepare('DELETE FROM blog_comments WHERE id = ?');
        $statement->execute(array($id));
    }

    function customErrorHandler($fehlercode, $fehlertext, $fehlerdatei, $fehlerzeile)
    {
        if (!(error_reporting() & $fehlercode)) {
            return false;
        }

        switch ($fehlercode) {
            case E_USER_ERROR:
                echo "<div class='alert alert-danger'><i class='fa fas fa-exclamation-triangle'></i> (PHP) Fehler: [$fehlercode] $fehlertext<br />";
                echo "  Fataler Fehler in Zeile $fehlerzeile in der Datei $fehlerdatei";
                echo ", PHP " . PHP_VERSION . " (" . PHP_OS . ")</div>";
                exit(1);
                break;

            default:
                echo "<div class='alert alert-warning'><i class='fa fas fa-exclamation-triangle'></i> (PHP) Warnung: [$fehlercode] $fehlertext</div>";
                break;
        }

        return true;
    }


    function unique_multidim_array($array, $key) {
        $temp_array = array();
        $i = 0;
        $key_array = array();

        foreach($array as $val) {
            if (!in_array($val[$key], $key_array)) {
                $key_array[$i] = $val[$key];
                $temp_array[$i] = $val;
            }
            $i++;
        }
        return $temp_array;
    }
}