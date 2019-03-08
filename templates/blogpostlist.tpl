{include file="header.tpl" title="Blogeinträge" admin=$data.user.admin}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-8">
            {foreach $data.notifications as $notification}
                {if $notification.type == "warning"}
                    {assign var="icon" value="fas fa-exclamation"}
                {elseif $notification.type == "success"}
                    {assign var="icon" value="fas fa-check"}
                {elseif $notification.type == "info"}
                    {assign var="icon" value="fas fa-info"}
                {/if}
                <div class="alert alert-{$notification.type}" style="margin-top: 25px;"><i class="{$icon}"></i> {$notification.text}</div>
            {/foreach}

            {foreach from=$data.blog_entries item=blogentry}
            <div class="card my-4">
                <h5 class="card-header"><a href="?id={$blogentry.id}">{$blogentry.title}</a></h5>
                <div class="card-body">
                    {$blogentry.text|truncate:1024:"...":false nofilter}
                </div>
                <div class="card-footer">
                    von <a href="?search={$blogentry.author}">{$blogentry.author}</a>
                </div>
            </div>
            {/foreach}
        </div>
        <div class="col-md-4">
            <div class="card my-4">
                <h5 class="card-header">Suche</h5>
                <div class="card-body">
                    <form method="get" action="{$smarty.server.PHP_SELF}">
                        <div class="input-group">
                            <input type="text" class="form-control" name="search" placeholder="Suchbegriff">
                            <span class="input-group-btn"><button class="btn btn-secondary" type="button">OK</button></span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


{include file="footer.tpl"}