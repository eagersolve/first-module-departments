<div class="ty-feature">
    {if $department_data.main_pair}
    <div class="ty-feature__image">
        {include "common/image.tpl" 
        images=$department_data.main_pair
        image_width=$settings.Thumbnails.product_lists_thumbnail_width 
        image_height=$settings.Thumbnails.product_lists_thumbnail_height         
        }
    </div>
    {/if}
    <div>
        <div class="ty-feature__description ty-wysiwyg-content">
            {$department_data.description nofilter}
        </div>
    </div>
</div>

{if $full_name}
    <div>
        {__("director")} {_(":")} {$full_name}
    </div>
{/if}

{if $department_data['users_id']}
    {__("staff")} {_(":")} 
    <div>
        {fn_get_staff_name($department_data)}
    </div>
{/if}

{capture name="mainbox_title"}{$department_data.variant nofilter}{/capture}
