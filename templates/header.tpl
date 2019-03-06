<html lang="de">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>{$title|default:"Kein Titel"}</title>

        <link href="https://cdn.irequire.dev/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.irequire.dev/fontawesome/5.7.2/css/all.min.css" rel="stylesheet">

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
            <a class="navbar-brand" href="index.php">Smarty</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Blog
                            <span class="sr-only">(current)</span>
                        </a>
                    </li>
                    {if $admin}
                        <li class="nav-item">
                            <a class="nav-link" href="#" style="color: red">(ADMIN-MODE)</a>
                        </li>
                    {/if}
                </ul>
            </div>
        </div>
    </nav>