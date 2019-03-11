{foreach $notifications as $notification}
    {if $notification.type == "danger"}
        {assign var="icon" value="fas fa-exclamation"}
    {elseif $notification.type == "warning"}
        {assign var="icon" value="fas fa-exclamation"}
    {elseif $notification.type == "success"}
        {assign var="icon" value="fas fa-check"}
    {elseif $notification.type == "info"}
        {assign var="icon" value="fas fa-info"}
    {/if}
    <div class="toast" style="width: 400px; display: inline-block; position: fixed; z-index: 1000; top: 60px; margin-left: calc(50% - 200px);" data-delay="5000">
        <div class="toast-header">
            <strong class="mr-auto">Benachrichtigung</strong>
            <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="toast-body alert-{$notification.type}">
            <i class="{$icon}"></i> {$notification.text}
        </div>
    </div>
{/foreach}