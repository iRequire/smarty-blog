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

    public function addComment($blog_id, $user, $text){
        $statement = $this->pdo->prepare("INSERT INTO blog_comments (blogid, name, text, date) VALUES (?, ?, ?, ?)");
        $statement->execute(array($blog_id, $user, $text, time()));
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
}