{include file="include/header.tpl" title="Suche: {$data.search_query}" admin=$data.user.admin}
{include file="include/notifications.tpl" notifications=$data.notifications}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-8 shadow">
            {include file="include/breadcrumb.tpl" activePage="Suche"}
            <h1 class="mt-4">Suchergebnisse: "{$data.search_query}"</h1>

            {if !empty($data.search_items)}
                {foreach $data.search_items as $searchitem}
                    <div class="card my-4">
                        <h5 class="card-header"><a href="?p=blog&id={$searchitem.id}">{$searchitem.title}</a></h5>
                        <div class="card-body">
                            {$searchitem.text|truncate:1024:"...":false nofilter}
                        </div>
                        <div class="card-footer">
                            von <a href="?p=search&query={$searchitem.author}">{$searchitem.author}</a>
                        </div>
                    </div>
                {/foreach}
            {/if}
        </div>
        {include file="include/sidebar.tpl" user=$data.user}
    </div>
</div>


{include file="include/footer.tpl"}