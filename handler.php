<?php
require('Smarty.class.php');
class BlogHandler {

    public $smarty;
    public $pdo;

    public function __construct()
    {
        set_error_handler(array($this, "customErrorHandler"));


        $smarty = new Smarty;
        $smarty->template_dir = 'C:/xampp/htdocs/arbeit/smarty-blog/templates';
        $smarty->config_dir = 'C:/xampp/htdocs/arbeit/smarty-blog/config';
        $smarty->cache_dir = 'C:/xampp/smarty/cache';
        $smarty->compile_dir = 'C:/xampp/smarty/templates_c';
        $smarty->default_modifiers = array('escape:"html"');
        $this->smarty = $smarty;

        $pdo = new PDO('mysql:host=localhost;dbname=arbeit;charset=utf8', 'root', '');
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

        return (($rowcount > 0) ? $row : false);
    }

    public function getBlogEntries(){
        $blog_entries = array();
        $statement = $this->pdo->prepare("SELECT * FROM blog_entries ORDER BY id DESC");
        $statement->execute();
        while($row = $statement->fetch()) {
            $blog_entries[] = $row;
        }

        return $blog_entries;
    }

    public function getBlogComments($blog_id){
        $comments = array();
        $statement = $this->pdo->prepare("SELECT * FROM blog_comments WHERE `blogid` = ? ORDER BY id DESC");
        $statement->execute(array($blog_id));
        while($row = $statement->fetch()) {
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
            $blog_entries[] = $row;
        }
        $count += $statement->rowCount();

        $statement = $this->pdo->prepare("SELECT * FROM blog_entries WHERE author LIKE ?");
        $statement->execute(array('%'.$search_query.'%'));
        while($row = $statement->fetch()) {
            $blog_entries[] = $row;
        }
        $count += $statement->rowCount();

        $statement = $this->pdo->prepare("SELECT * FROM blog_entries WHERE text LIKE ?");
        $statement->execute(array('%'.$search_query.'%'));
        while($row = $statement->fetch()) {
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

    public function addComment($blog_id, $user, $text){
        $statement = $this->pdo->prepare("INSERT INTO blog_comments (blogid, name, text, date) VALUES (?, ?, ?, ?)");
        $statement->execute(array($blog_id, $user, $text, time()));
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

    function customErrorHandler($fehlercode, $fehlertext, $fehlerdatei, $fehlerzeile)
    {
        if (!(error_reporting() & $fehlercode)) {
            return;
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