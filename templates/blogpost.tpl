{include file="include/header.tpl" title=$data.blogpost.title  admin=$data.user.admin}
{include file="include/notifications.tpl" notifications=$data.notifications}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-8 shadow">
            {include file="include/breadcrumb.tpl" activePage="Blogpost: '{$data.blogpost.title}'"}

            <h1 class="mt-4">{$data.blogpost.title}</h1>
            <p class="lead">
                Veröffentlicht am {$data.blogpost.date|date_format:"%d.%m.%Y %H:%M"} von <a href="?p=search&query={$data.blogpost.author_name}">{$data.blogpost.author_name}</a>
            </p>
            <hr>
            <p class="lead">{$data.blogpost.text nofilter}</p>

            {if $data.user.admin}
                <hr>
                <form method="post" action="">
                    <input type="hidden" name="admin__blogID" value="{$data.blogpost.id}">
                    <button class="btn btn-sm btn-danger" name="admin__do" value="deleteBlogPost"><i class="fas fa-times"></i> Blogpost löschen</button>
                    {if $data.blogpost.enable_comments}
                        <button class="btn btn-sm btn-warning" name="admin__do" value="toggleBlogComments"><i class="fas fa-minus"></i> Kommentare deaktivieren</button>
                    {else}
                        <button class="btn btn-sm btn-success" name="admin__do" value="toggleBlogComments"><i class="fas fa-plus"></i> Kommentare aktivieren</button>
                    {/if}
                </form>
            {/if}
            <hr>
            <h3>Kommentare</h3>
            {if $data.blogpost.enable_comments}
                {if $data.user.loggedin}
                    <div class="card my-4 shadow">
                        <h5 class="card-header">Hinterlasse einen Kommentar:</h5>
                        <div class="card-body">
                            <form method="post" action="">
                                <input type="hidden" name="addComment" value="1">
                                <input type="hidden" name="comment_blogid" value="{$data.blogpost.id}">
                                <div class="form-group">
                                    <input class="form-control" type="text" value="{$data.user.firstname} {$data.user.lastname}" readonly>
                                </div>
                                <div class="form-group">
                                    <textarea class="form-control" name="comment_text" placeholder="Kommentar" rows="3"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary">Absenden</button>
                            </form>
                        </div>
                    </div>
                {else}
                    <div class="alert alert-warning"><i class="fas fa-exclamation"></i> Du musst eingeloggt sein, um Kommentare verfassen zu können.</div>
                {/if}
            {else}
                <div class="alert alert-info"><i class="fas fa-info"></i> Weitere Kommentare wurden für diesen Blogeintrag deaktiviert.</div>
            {/if}

            {foreach from=$data.comments item=comment}
                {assign var=rand value=0|mt_rand:99}
                <hr>
                <div class="media mb-4">
                    <img class="d-flex mr-3 rounded-circle" src="https://randomuser.me/api/portraits/men/{$rand}.jpg" height="40px" width="40px" alt="">
                    <div class="media-body">
                        <h5 class="mt-0">
                            {$comment.author_name} ({$comment.date|date_format:"%d.%m.%Y %H:%M"})
                        </h5>
                        {$comment.text}
                    </div>
                    {if $data.user.admin}
                        <form method="post" action="">
                            <input type="hidden" name="admin__do" value="deleteComment">
                            <input type="hidden" name="admin__commentID" value="{$comment.id}">
                            <button class="btn btn-sm btn-danger"><i class="fas fa-times"></i> Kommentar löschen</button>
                        </form>
                    {/if}
                </div>
            {/foreach}
        </div>
        <!-- Sidebar Widgets Column -->
        {include file="include/sidebar.tpl" user=$data.user}
    </div>
</div>




{include file="include/footer.tpl"}