<?php 

use Tygh\Tygh;

defined('BOOTSTRAP') or die('Access denied');

if ($mode === 'departments') {

    $params = $_REQUEST;
    list($departments, $search) = fn_get_departments($params, $items_per_page = 3, CART_LANGUAGE);
    Tygh::$app['view']->assign(['departments' => $departments, 'search' => $search, 'columns' => 3]);

    if (isset($search['page']) && ($search['page'] > 1) && empty($departments)) {
        return [(CONTROLLER_STATUS_NO_PAGE)];
    }
    fn_add_breadcrumb(__('departments'));
} elseif ($mode === 'department') {
    
    $department_data = [];
    $department_id = !empty($_REQUEST['department_id']) ? $_REQUEST['department_id'] : 0;
    $department_data = fn_get_department_data($department_id, CART_LANGUAGE);
    $full_name = fn_get_user_name($department_data['user_id']);

    if (empty($department_data)) {
        return [(CONTROLLER_STATUS_NO_PAGE)];
    }

    Tygh::$app['view']->assign(['full_name' => $full_name, 'department_data' => $department_data]);

    fn_add_breadcrumb(__('departments'), fn_url('departments.departments'));
    fn_add_breadcrumb($department_data['department']);
}
