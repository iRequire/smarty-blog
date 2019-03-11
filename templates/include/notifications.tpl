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
    <div class="alert alert-{$notification.type} alert-dismissible shadow" style="margin-top: 25px;">
        <a href="#" class="close" data-dismiss="alert" aria-label="close"><i class="fas fa-times"></i></a>
        <i class="{$icon}"></i> {$notification.text}
    </div>
{/foreach}