{include file="include/header.tpl" title="Suche: {$data.search_query}" admin=$data.user.admin}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-8">
            <h1 class="mt-4">Suchergebnisse: "{$data.search_query}"</h1>
            {include file="include/notifications.tpl" notifications=$data.notifications}

            {if !empty($data.search_items)}
                {foreach $data.search_items as $searchitem}
                    <div class="card my-4">
                        <h5 class="card-header"><a href="?id={$searchitem.id}">{$searchitem.title}</a></h5>
                        <div class="card-body">
                            {$searchitem.text|truncate:1024:"...":false nofilter}
                        </div>
                        <div class="card-footer">
                            von <a href="?search={$searchitem.author}">{$searchitem.author}</a>
                        </div>
                    </div>
                {/foreach}
            {/if}
        </div>
        <div class="col-md-4">
            <div class="card my-4">
                <h5 class="card-header">Suche</h5>
                <div class="card-body">
                    <form method="get" action="{$smarty.server.PHP_SELF}">
                        <div class="input-group">
                            <input type="text" class="form-control" name="search" placeholder="Suchbegriff" value="{$smarty.get.search}">
                            <span class="input-group-btn"><button class="btn btn-secondary" type="button">OK</button></span>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


{include file="include/footer.tpl"}