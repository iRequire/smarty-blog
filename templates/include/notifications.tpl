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
    <div class="alert alert-{$notification.type} shadow" style="margin-top: 25px;"><i class="{$icon}"></i> {$notification.text}</div>
{/foreach}