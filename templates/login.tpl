{include file="include/header.tpl" title="Login" admin=$data.user.admin}
{include file="include/notifications.tpl" notifications=$data.notifications}

<div class="container">
    <div class="row justify-content-md-center">
        <div class="col-lg-6">

            <div class="card my-4 shadow">
                <h5 class="card-header text-center">{$data.ui.TEXT_UI_LOGIN}</h5>
                <div class="card-body">
                    <form method="post" action="">
                        <input type="hidden" name="login" value="true">
                        <div class="input-group">
                            <input type="text" class="form-control" name="username" placeholder="{$data.ui.TEXT_UI_USERNAME}" required>
                            <input type="password" class="form-control" name="password" placeholder="{$data.ui.TEXT_UI_PASSWORD}" minlength="8" required>
                            <span class="input-group-btn"><button class="btn btn-secondary" type="submit">OK</button></span>
                        </div>
                    </form>
                    <a href="?p=register">{$data.ui.TEXT_UI_REGISTERNOTICE}</a>
                </div>
            </div>
        </div>
    </div>
</div>


{include file="include/footer.tpl"}