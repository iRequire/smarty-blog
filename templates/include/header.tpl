<html lang="de">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>{$title|default:"No title"}</title>

        <link rel="shortcut icon" type="image/x-icon" href="favicon.png">

        <link href="https://cdn.irequire.dev/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.irequire.dev/fontawesome/5.7.2/css/all.min.css" rel="stylesheet">

        <link href="https://cdn.irequire.dev/libs/quill/quill.snow.css" rel="stylesheet">

        {literal}
        <style>
            body {
                padding-top: 56px;
                background: url('bg.png') fixed no-repeat;
                background-size: cover;
            }
            .pagebg {
                background-color: white;
            }
            .footer {
                text-align: center;
                color: white;
            }
        </style>
        {/literal}
    </head>
    <body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href=".">Smarty</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    {if $data.user.loggedin > 0}
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                {$data.user.firstname} {$data.user.lastname} ({$data.user.username})
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="#">Action</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="?p=logout"><i class="fas fa-sign-out-alt"></i> {$data.ui.TEXT_UI_LOGOUT}</a>
                            </div>
                        </li>
                    {else}
                        <li class="nav-item">
                            <a class="nav-link" href="?p=login"><i class="fas fa-sign-in-alt"></i> {$data.ui.TEXT_UI_LOGIN}</a>
                        </li>
                    {/if}
                    {if $data.user.admin}
                        <li class="nav-item">
                            <a class="nav-link" href="?p=admin" style="color: red">ADMIN</a>
                        </li>
                    {/if}
                </ul>
            </div>
        </div>
    </nav>