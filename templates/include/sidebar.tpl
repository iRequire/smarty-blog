<div class="col-md-4">
    <div style="text-align: center;">
        <a class="btn btn-sm btn-primary" href="?p=changeLanguage&newLanguage=en"><img class="mx-auto d-block" height="16" src="templates/include/img/en.png" alt="EN"/> English</a>
        <a class="btn btn-sm btn-primary" href="?p=changeLanguage&newLanguage=de"><img class="mx-auto d-block" height="16" src="templates/include/img/de.png" alt="DE"/> Deutsch</a>
    </div>
    <div class="card my-4 shadow">
        <h5 class="card-header">{$data.ui.TEXT_UI_SEARCH}</h5>
        <div class="card-body">
            <form method="get" action="">
                <div class="input-group">
                    <input type="hidden" name="p" value="search">
                    <input type="text" class="form-control" name="query" placeholder="{$data.ui.TEXT_UI_SEARCHQUERY}">
                    <span class="input-group-btn"><button class="btn btn-secondary" type="submit">OK</button></span>
                </div>
            </form>
        </div>
    </div>
</div>