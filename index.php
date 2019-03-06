<?php
set_error_handler("customErrorHandler");
// load Smarty library
require('Smarty.class.php');
$smarty = new Smarty;
$smarty->template_dir = 'C:/xampp/htdocs/arbeit/smarty-blog/templates';
$smarty->config_dir = 'C:/xampp/htdocs/arbeit/smarty-blog/config';
$smarty->cache_dir = 'C:/xampp/smarty/cache';
$smarty->compile_dir = 'C:/xampp/smarty/templates_c';
if(isset($_GET['debug'])) {
    $smarty->debugging = true;
}

$pdo = new PDO('mysql:host=localhost;dbname=arbeit', 'root', '');

$blogentry = array();

if(isset($_GET['id'])){
    $id = $_GET['id'];

    $stmt = $pdo->prepare("SELECT * FROM blog_entries WHERE id=? LIMIT 1");
    $stmt->execute(array($id));
    $row = $stmt->fetch();
    $rowcount = $stmt->rowCount();

    if($rowcount > 0) {
        $blogpost = $row;
        $smarty->assign("blogpost", $blogpost);

        $comments = array(
            array("name" => "Peter Fröhlich", "text" => "Cooler Blog", "date" => 1),
            array("name" => "Max Peters", "text" => "Ich bin ein Kommentar", "date" => time()));
        $smarty->assign("comments", $comments);


        $smarty->display('blogpost.tpl');
    }else{
        $smarty->assign("notfound", true);

        $blog_entries = array();
        $statement = $pdo->prepare("SELECT * FROM blog_entries ORDER BY id DESC");
        $statement->execute();
        while($row = $statement->fetch()) {
            $blog_entries[] = $row;
        }
        $smarty->assign("blog_entries", $blog_entries);
        $smarty->display('blogpostlist.tpl');
    }
}else{
    $smarty->assign("notfound", false);

    $blog_entries = array();
    $statement = $pdo->prepare("SELECT * FROM blog_entries ORDER BY id DESC");
    $statement->execute();
    while($row = $statement->fetch()) {
        $blog_entries[] = $row;
    }
    $smarty->assign("blog_entries", $blog_entries);
    $smarty->display('blogpostlist.tpl');
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

