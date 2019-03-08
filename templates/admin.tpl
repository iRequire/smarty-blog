{include file="header.tpl" title="Admin" admin=$data.user.admin}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-12 shadow">
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
                                    <td class="float-right">
                                        {if $user.admin}
                                            <a href="?adm_togAdmin={$user.id}" class="btn-sm btn-warning"><i class="fas fa-chevron-down"></i> Adminrechte entfernen</a>
                                        {else}
                                            <a href="?adm_togAdmin={$user.id}" class="btn-sm btn-success"><i class="fas fa-chevron-up"></i> Zum Admin machen</a>
                                        {/if}
                                        <a href="?adm_delUser={$user.id}" class="btn-sm btn-danger"><i class="fas fa-times"></i> Löschen</a>
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


{include file="footer.tpl"}