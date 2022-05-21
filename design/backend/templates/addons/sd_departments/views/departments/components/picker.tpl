{math equation="rand()" assign="rnd"}
{$data_id=$picker_id|default:"{$data_id}_{$rnd}"}
{$view_mode=$view_mode|default:"mixed"}
{$show_but_text=$show_but_text|default:"true"}

{if $item_ids && !$item_ids|is_array}
    {$item_ids=","|explode:$item_ids}
{/if}

{$display=$display|default:"checkbox"}

{if $view_mode != "list" && $view_mode != "single_button"}

    {if $user_type == "A"}
    {include "design/backend/templates/buttons/button.tpl" 
    but_id="opener_picker_`$data_id`" 
    but_href="departments.picker?display=`$display`&extra=`$extra_var`&picker_for=`$picker_for`&data_id=`$data_id`&shared_force=`$shared_force``$extra_url`"|fn_url 
    but_role="add" 
    but_target_id="content_`$data_id`" 
    but_meta="cm-dialog-opener `$but_meta`" 
    but_icon=$but_icon
    }
    {else}
    {include "design/backend/templates/buttons/button.tpl" 
    but_id="opener_picker_`$data_id`" 
    but_href="profiles.picker?display=`$display`&extra=`$extra_var`&picker_for=`$picker_for`&data_id=`$data_id`&shared_force=`$shared_force``$extra_url`"|fn_url 
    but_role="add" 
    but_target_id="content_`$data_id`" 
    but_meta="cm-dialog-opener `$but_meta`" 
    but_icon=$but_icon
    }
    {/if}

    {if $placement == 'right'}
        </div></div>
    {/if}

{/if}

{if $view_mode == "single_button"}
    {if $user_info}
        {$user_name = "`$user_info.firstname` `$user_info.lastname`"}
        {$item_ids = $user_info.user_id}
    {/if}

    {$_but_text=__("choose_user")}
    <div class="mixed-controls">
    <div class="form-inline">
    <span id="{$data_id}" class="cm-js-item cm-display-radio">

    <div class="input-append">
    <input class="cm-picker-value-description {$extra_class}" type="text" value="{$user_name}" {if $display_input_id}id="{$display_input_id}"{/if} size="10" name="user_name" readonly="readonly" {$extra}>

    {if $user_type == "A"}
    {include "design/backend/templates/buttons/button.tpl" 
    but_id="opener_picker_`$data_id`" 
    but_href="departments.picker?display=`$display`&picker_for=`$picker_for`&extra=`$extra_var`&checkbox_name=`$checkbox_name`&root=`$default_name`&except_id=`$except_id`&data_id=`$data_id``$extra_url`"|fn_url 
    but_role="text" 
    but_icon="icon-plus" 
    but_target_id="content_`$data_id`" 
    but_meta="`$but_meta` cm-dialog-opener add-on btn"
    }
    {else}
    {include "design/backend/templates/buttons/button.tpl" 
    but_id="opener_picker_`$data_id`" 
    but_href="profiles.picker?display=`$display`&picker_for=`$picker_for`&extra=`$extra_var`&checkbox_name=`$checkbox_name`&root=`$default_name`&except_id=`$except_id`&data_id=`$data_id``$extra_url`"|fn_url 
    but_role="text" 
    but_icon="icon-plus"
    but_target_id="content_`$data_id`" 
    but_meta="`$but_meta` cm-dialog-opener add-on btn"
    }
    {/if}

    <input id="{if $input_id}{$input_id}{else}u{$data_id}_ids{/if}" type="hidden" class="cm-picker-value" name="{$input_name}" value="{if $item_ids|is_array}{","|implode:$item_ids}{else}{$item_ids}{/if}" {$extra} />

    </div>
    </span>
    </div>
    </div>
{/if}
