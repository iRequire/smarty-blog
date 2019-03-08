{include file="header.tpl" title="Registrierung" admin=$data.user.admin}

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
                <h5 class="card-header text-center">Registrierung</h5>
                <div class="card-body">
                    <div class="alert alert-info" style="margin-top: 25px;"><i class="fas fa-info"></i> Diese Daten werden streng vertraulich behandelt und niemals mit Dritten geteilt.</div>
                    <form method="post" action="{$smarty.server.PHP_SELF}">
                        <input type="hidden" name="register" value="true">
                        <div class="form-group">
                            <div class="row">
                                <div class="col">
                                    <input type="text" class="form-control" name="firstname" placeholder="Vorname" required>
                                </div>
                                <div class="col">
                                    <input type="text" class="form-control" name="lastname" placeholder="Nachname" required>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" name="username" placeholder="Nutzername" required>
                        </div>
                        <div class="form-group">
                            <input type="email" class="form-control" name="email" placeholder="Email-Adresse" required>
                        </div>
                        <div class="form-group">
                             <input type="password" class="form-control" name="password" placeholder="Passwort" minlength="8" required>
                        </div>
                        <div class="form-group">
                             <input type="password" class="form-control" name="password2" placeholder="Passwort wiederholen" minlength="8" required>
                        </div>
                        <span class="input-group-btn"><button class="btn btn-secondary" type="submit">OK</button></span>
                    </form>
                    <a href="?login">Bereits registriert? Hier anmelden!</a>
                </div>
            </div>
        </div>
    </div>
</div>


{include file="footer.tpl"}