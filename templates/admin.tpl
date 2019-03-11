{include file="include/header.tpl" title="Admin" admin=$data.user.admin}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-12 shadow">
            {include file="include/notifications.tpl" notifications=$data.notifications}

            <div class="card my-4 shadow">
                <h5 class="card-header">Benutzerverwaltung</h5>
                <div class="card-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Nutzername</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Registrierungsdatum</th>
                                <th>Admin</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            {foreach $data.users as $user}
                                <tr>
                                    <td>{$user.id}</td>
                                    <td>{$user.username}</td>
                                    <td>{$user.firstname} {$user.lastname}</td>
                                    <td>{$user.email}</td>
                                    <td>{$user.register_date|date_format:"%d.%m.%Y %H:%M"}</td>
                                    <td>
                                        {if $user.admin}
                                            <span class="badge badge-success">Ja</span>
                                        {else}
                                            <span class="badge badge-danger">Nein</span>
                                        {/if}
                                    </td>
                                    <td>
                                        <span class="float-right">
                                            {if $user.admin}
                                                <a href="?adm_togAdmin={$user.id}" class="btn-sm btn-warning"><i class="fas fa-chevron-down"></i> Adminrechte entfernen</a>
                                            {else}
                                                <a href="?adm_togAdmin={$user.id}" class="btn-sm btn-success"><i class="fas fa-chevron-up"></i> Zum Admin machen</a>
                                            {/if}
                                            <a href="?adm_delUser={$user.id}" class="btn-sm btn-danger"><i class="fas fa-times"></i> Löschen</a>
                                        </span>
                                    </td>
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