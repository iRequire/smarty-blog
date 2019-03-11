{include file="include/header.tpl" title="Blogeinträge" admin=$data.user.admin}
{include file="include/notifications.tpl" notifications=$data.notifications}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-12">
            {include file="include/breadcrumb.tpl" activePage="Blogeinträge"}
        </div>
        <div class="col-lg-8 shadow">
            {if $data.user.isAuthor}
                <a href="?p=createBlogPost" class="btn btn-info"><i class="fas fa-plus"></i> Neuer Blogeintrag</a>
            {/if}
            {foreach from=$data.blog_entries item=blogentry}
            <div class="card my-4 shadow">
                <h5 class="card-header"><span class="float-left"><a href="?p=blog&id={$blogentry.id}">{$blogentry.title}</a></span><span class="float-right">#{$blogentry.id}</span></h5>
                <div class="card-body">
                    {$blogentry.text|truncate:1024:"...":false nofilter}
                </div>
                <div class="card-footer align-middle">
                    veröffentlicht am {$blogentry.date|date_format:"%d.%m.%Y %H:%M"} von <a href="?p=search&query={$blogentry.author}">{$blogentry.author}</a>
                </div>
            </div>
            {/foreach}
        </div>
        {include file="include/search.tpl"}
    </div>
</div>


{include file="include/footer.tpl"}