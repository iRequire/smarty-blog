{include file="include/header.tpl" title="Login" admin=$data.user.admin}

<div class="container">
    <div class="row justify-content-md-center">
        <div class="col-lg-6">
            {include file="include/notifications.tpl" notifications=$data.notifications}

            <div class="card my-4 shadow">
                <h5 class="card-header text-center">Anmeldung</h5>
                <div class="card-body">
                    <form method="post" action="{$smarty.server.PHP_SELF}">
                        <input type="hidden" name="login" value="true">
                        <div class="input-group">
                            <input type="text" class="form-control" name="username" placeholder="Nutzername" required>
                            <input type="password" class="form-control" name="password" placeholder="Passwort" minlength="8" required>
                            <span class="input-group-btn"><button class="btn btn-secondary" type="submit">OK</button></span>
                        </div>
                    </form>
                    <a href="?p=register">Noch nicht registriert? Hier registrieren!</a>
                </div>
            </div>
        </div>
    </div>
</div>


{include file="include/footer.tpl"}