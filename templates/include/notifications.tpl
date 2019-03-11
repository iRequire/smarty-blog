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
    <div class="toast" style="position: fixed; z-index: 1000; right: 10px; top: 60px;" data-delay="5000">
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