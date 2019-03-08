{include file="header.tpl" title="Login" admin=$data.user.admin}

<div class="container">
    <div class="row justify-content-md-center">
        <div class="col-lg-6">
            {foreach $data.notifications as $notification}
                {if $notification.type == "danger"}
                    {assign var="icon" value="fas fa-exclamation"}
                {elseif $notification.type == "warning"}
                    {assign var="icon" value="fas fa-exclamation"}
                {elseif $notification.type == "success"}
                    {assign var="icon" value="fas fa-check"}
                {elseif $notification.type == "info"}
                    {assign var="icon" value="fas fa-info"}
                {/if}
                <div class="alert alert-{$notification.type} shadow" style="margin-top: 25px;"><i class="{$icon}"></i> {$notification.text}</div>
            {/foreach}

            <div class="card my-4 shadow">
                <h5 class="card-header text-center">Anmeldung</h5>
                <div class="card-body">
                    <form method="post" action="{$smarty.server.PHP_SELF}">
                        <input type="hidden" name="login" value="true">
                        <div class="input-group">
                            <input type="text" class="form-control" name="username" placeholder="Nutzername">
                            <input type="password" class="form-control" name="password" placeholder="Passwort">
                            <span class="input-group-btn"><button class="btn btn-secondary" type="submit">OK</button></span>
                        </div>
                    </form>
                    <a href="?register">Noch nicht registriert? Hier registrieren!</a>
                </div>
            </div>
        </div>
    </div>
</div>


{include file="footer.tpl"}