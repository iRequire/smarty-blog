{include file="header.tpl" title="Blogeinträge"}

<div class="container pagebg">
    <div class="row">
        <div class="col-lg-12">
            {if $data.notfound}
                <div class="alert alert-warning" style="margin-top: 25px;"><i class="fa fas fa-exclamation-triangle"></i> Der angeforderte Blogeintrag konnte nicht gefunden werden.</div>
            {/if}

            {foreach from=$data.blog_entries item=blogentry}
            <div class="card my-4">
                <h5 class="card-header"><a href="?id={$blogentry.id}">{$blogentry.title}</a></h5>
                <div class="card-body">
                    {$blogentry.text|truncate:1024:"...":false}
                </div>
            </div>
            {/foreach}
        </div>
    </div>
</div>


{include file="footer.tpl"}