{include file="header.tpl" title=$blogpost.title}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-8">
            <h1 class="mt-4">{$blogpost.title}</h1>
            <p class="lead">
                Veröffentlicht am {$blogpost.date|date_format:"%d.%m.%Y %H:%M"} von <a href="#">{$blogpost.author}</a>
            </p>
            <hr>
            <p class="lead">{$blogpost.text}</p>


            <hr>
            <h3>Kommentare</h3>
            {if $blogpost.enable_comments}
                <div class="card my-4">
                    <h5 class="card-header">Hinterlasse einen Kommentar:</h5>
                    <div class="card-body">
                        <form>
                            <div class="form-group">
                                <textarea class="form-control" rows="3"></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Absenden</button>
                        </form>
                    </div>
                </div>
            {else}
                <div class="alert alert-info"><i class="fa fas fa-exclamation-triangle"></i> Kommentare wurden für diesen Blogeintrag deaktiviert.</div>
            {/if}

            {foreach from=$comments item=comment}
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
            <div class="card my-4">
                <h5 class="card-header">Suche</h5>
                <div class="card-body">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Suchbegriff">
                        <span class="input-group-btn"><button class="btn btn-secondary" type="button">OK</button></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




{include file="footer.tpl"}