{include file="include/header.tpl" title="{$data.ui.TEXT_UI_BLOGPOSTS}" admin=$data.user.admin}
{include file="include/notifications.tpl" notifications=$data.notifications}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-12">
            {include file="include/breadcrumb.tpl" activePage="{$data.ui.TEXT_UI_BLOGPOSTS}"}
        </div>
        {if $data.user.isAuthor}
            <div class="col-lg-12">
                <a href="?p=createBlogPost" class="btn btn-info"><i class="fas fa-plus"></i> {$data.ui.TEXT_UI_BLOGPOSTS}</a>
            </div>
        {/if}
        <div class="col-lg-8 shadow">
            {foreach from=$data.blog_entries item=blogentry}
            <div class="card my-4 shadow">
                <h5 class="card-header"><span class="float-left"><a href="?p=blog&id={$blogentry.id}">{$blogentry.title}</a></span><span class="float-right">#{$blogentry.id}</span></h5>
                <div class="card-body">
                    {$blogentry.text|truncate:1024:"...":false nofilter}
                </div>
                <div class="card-footer align-middle">
                    <i class="fas fa-user"></i> <a href="?p=search&query={$blogentry.author_name}">{$blogentry.author_name}</a> ({$blogentry.date|date_format:"%d.%m.%Y %H:%M"})
                </div>
            </div>
            {/foreach}
        </div>
        {include file="include/sidebar.tpl" user=$data.user}
    </div>
</div>


{include file="include/footer.tpl"}