{include file="header.tpl" title=$data.blogpost.title  admin=$data.user.admin}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-8 shadow">
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
            <h1 class="mt-4">{$data.blogpost.title}</h1>
            <p class="lead">
                Veröffentlicht am {$data.blogpost.date|date_format:"%d.%m.%Y %H:%M"} von <a href="?search={$data.blogpost.author}">{$data.blogpost.author}</a>
            </p>
            <hr>
            <p class="lead">{$data.blogpost.text nofilter}</p>


            <hr>
            <h3>Kommentare</h3>
            {if $data.blogpost.enable_comments}
                {if $data.user.loggedin}
                    <div class="card my-4 shadow">
                        <h5 class="card-header">Hinterlasse einen Kommentar:</h5>
                        <div class="card-body">
                            <form method="post" action="{$smarty.server.PHP_SELF}">
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
                <div class="media mb-4">
                    <img class="d-flex mr-3 rounded-circle" src="https://randomuser.me/api/portraits/men/{$rand}.jpg" height="40px" width="40px" alt="">
                    <div class="media-body">
                        <h5 class="mt-0">{$comment.name} ({$comment.date|date_format:"%d.%m.%Y %H:%M"})</h5>
                        {$comment.text}
                    </div>
                </div>
            {/foreach}

            <!-- Comment with nested comments
            <div class="media mb-4">
                <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
                <div class="media-body">
                    <h5 class="mt-0">Commenter Name</h5>
                    Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.

                    <div class="media mt-4">
                        <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
                        <div class="media-body">
                            <h5 class="mt-0">Commenter Name</h5>
                            Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
                        </div>
                    </div>

                    <div class="media mt-4">
                        <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
                        <div class="media-body">
                            <h5 class="mt-0">Commenter Name</h5>
                            Cras sit amet nibh libero, in gravida nulla. Nulla vel metus scelerisque ante sollicitudin. Cras purus odio, vestibulum in vulputate at, tempus viverra turpis. Fusce condimentum nunc ac nisi vulputate fringilla. Donec lacinia congue felis in faucibus.
                        </div>
                    </div>

                </div>
            </div>
            -->

        </div>
        <!-- Sidebar Widgets Column -->
        <div class="col-md-4">
            <div class="card my-4 shadow">
                <h5 class="card-header">Suche</h5>
                <div class="card-body">
                    <form method="get" action="{$smarty.server.PHP_SELF|escape}">
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