{include file="header.tpl" title="Neuer Blogeintrag"  admin=$data.user.admin}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="text-center">Blogeintrag erstellen</h1>
            {foreach $data.notifications as $notification}
                {if $notification.type == "warning"}
                    {assign var="icon" value="fas fa-exclamation"}
                {elseif $notification.type == "success"}
                    {assign var="icon" value="fas fa-check"}
                {elseif $notification.type == "info"}
                    {assign var="icon" value="fas fa-info"}
                {/if}
                <div class="alert alert-{$notification.type} shadow" style="margin-top: 25px;"><i class="{$icon}"></i> {$notification.text}</div>
            {/foreach}
            <form id="createBlog" method="post" action="{$smarty.server.PHP_SELF}">
                <input type="hidden" name="blog_text" id="blog_text">
                <h1 class="mt-4"><input type="text" class="form-control" name="blog_title" placeholder="Titel"></h1>
                <hr>
                <p class="lead">
                    <div id="editor" style="max-height: 400px;">

                    </div>
                </p>
                <input type="submit" class="btn btn-info" value="Absenden">
            </form>
        </div>
    </div>
</div>




{include file="footer.tpl" editor=true}