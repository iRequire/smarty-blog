{include file="include/header.tpl" title="{$data.ui.TEXT_UI_SEARCH}: {$data.search_query}" admin=$data.user.admin}
{include file="include/notifications.tpl" notifications=$data.notifications}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-8 shadow">
            {include file="include/breadcrumb.tpl" activePage="{$data.ui.TEXT_UI_SEARCH}"}
            <h1 class="mt-4">{$data.ui.TEXT_UI_SEARCH_RESULTS}: "{$data.search_query}"</h1>

            {if !empty($data.search_items)}
                {foreach $data.search_items as $searchitem}
                    <div class="card my-4">
                        <h5 class="card-header"><a href="?p=blog&id={$searchitem.id}">{$searchitem.title}</a></h5>
                        <div class="card-body">
                            {$searchitem.text|truncate:1024:"...":false nofilter}
                        </div>
                        <div class="card-footer">
                            <a href="?p=search&query={$searchitem.author_name}">{$searchitem.author_name}</a> ({$searchitem.date|date_format:"%d.%m.%Y %H:%M"})
                        </div>
                    </div>
                {/foreach}
            {/if}
        </div>
        {include file="include/sidebar.tpl" user=$data.user}
    </div>
</div>


{include file="include/footer.tpl"}