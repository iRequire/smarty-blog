{include file="include/header.tpl" title="Admin" admin=$data.user.admin}
{include file="include/notifications.tpl" notifications=$data.notifications}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-12 shadow">
            {include file="include/breadcrumb.tpl" activePage="Admin"}

            <div class="card my-4 shadow">
                <h5 class="card-header">Benutzerverwaltung</h5>
                <div class="card-body">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nutzername</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Registrierungsdatum</th>
                                <th>Autor</th>
                                <th>Admin</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="users">
                            {foreach $data.users as $user}
                                <tr>
                                    <td>{$user.id}</td>
                                    <td>{$user.username}</td>
                                    <td><a href="?p=search&query={$user.firstname} {$user.lastname}">{$user.firstname} {$user.lastname}</a></td>
                                    <td>{$user.email}</td>
                                    <td>{$user.register_date|date_format:"%d.%m.%Y %H:%M"}</td>
                                    <td>
                                        {if $user.isAuthor}
                                            <span class="badge badge-success">Ja</span>
                                        {else}
                                            <span class="badge badge-danger">Nein</span>
                                        {/if}
                                    </td>
                                    <td>
                                        {if $user.admin}
                                            <span class="badge badge-success">Ja</span>
                                        {else}
                                            <span class="badge badge-danger">Nein</span>
                                        {/if}
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group" aria-label="Basic example">
                                            <form method="post" action="">
                                                <input type="hidden" name="admin__userID" value="{$user.id}">
                                                {if $user.isAuthor}
                                                    <button type="submit" class="btn btn-sm btn-warning" name="admin__do" value="togAuthor" data-toggle="tooltip" data-placement="top" title="Autorenrechte entfernen"><i class="fas fa-angle-double-down"></i> Autor</button>
                                                {else}
                                                    <button type="submit" class="btn btn-sm btn-success" name="admin__do" value="togAuthor" data-toggle="tooltip" data-placement="top" title="Zum Autor ernennen"><i class="fas fa-angle-double-up"></i> Autor</button>
                                                {/if}
                                                {if $user.admin}
                                                    <button type="submit" class="btn btn-sm btn-warning" name="admin__do" value="togAdmin" data-toggle="tooltip" data-placement="top" title="Adminrechte entfernen"><i class="fas fa-angle-double-down"></i> Admin</button>
                                                {else}
                                                    <button type="submit" class="btn btn-sm btn-success" name="admin__do" value="togAdmin" data-toggle="tooltip" data-placement="top" title="Zum Admin ernennen"><i class="fas fa-angle-double-up"></i> Admin</button>
                                                {/if}
                                                <button type="submit" class="btn btn-sm btn-danger" name="admin__do" value="delete" data-toggle="tooltip" data-placement="top" title="Benutzer löschen"><i class="fas fa-times"></i> Löschen</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="card my-4 shadow">
                <h5 class="card-header">Konstanten</h5>
                <div class="card-body">
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>Category</th>
                            <th>Name</th>
                            <th>Value</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $data.constants|@array_reverse as $key=>$const}
                            {if $key == "DBPASS"}{assign var="const" value="** CENSORED **"}{/if}
                            {if $key|strpos:'TEXT'===0}
                                {assign var="type" value="primary"}
                                {assign var="category" value="Language"}
                            {elseif $key|strpos:'DB'===0}
                                {assign var="type" value="info"}
                                {assign var="category" value="Database"}
                            {elseif $key|strpos:'SMARTY'===0}
                                {assign var="type" value="warning"}
                                {assign var="category" value="Smarty"}
                            {else}
                                {assign var="type" value="default"}
                                {assign var="category" value="Unknown"}
                            {/if}
                            <tr class="table-{$type}">
                                <td>{$category}</td>
                                <td>{$key}</td>
                                <td>{$const}</td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>


{include file="include/footer.tpl"}