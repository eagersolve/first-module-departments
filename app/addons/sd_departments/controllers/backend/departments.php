<?php

use Tygh\Registry;
use Tygh\Tygh;
use Tygh\Enum\UserTypes;

defined('BOOTSTRAP') or die('Access denied');
$auth = & Tygh::$app['session']['auth'];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $suffix  = '.manage_departments';

    fn_trusted_vars(
        'department_data'
    );

    if ($mode === 'update_department') {
        $department_id = !empty($_REQUEST['department_id']) ? $_REQUEST['department_id'] : 0;
        $data = !empty($_REQUEST['department_data']) ? $_REQUEST['department_data'] : [];
        $department_id = fn_update_department($data, $department_id);     
          
        if (!empty($department_id)) {   
            $suffix = '.update_department?department_id=' . $department_id;
        } else  {
            $suffix = '.add_department';
        }      
    
    } elseif ($mode === 'update_departments') {
        if (!empty($_REQUEST['department_data'])) {
            foreach ($_REQUEST['department_data'] as $department_id => $data) { 
                fn_update_department($data,$department_id);
            }  
        } 
        $suffix = '.manage_departments';
    
    } elseif ($mode === 'delete_department') {
        $department_id = !empty($_REQUEST['department_id']) ? $_REQUEST['department_id'] : 0;
        fn_delete_department($department_id);
        $suffix = '.manage_departments';
    
    } elseif ($mode === 'delete_departments') {
        if (!empty($_REQUEST['departments_ids'])) {
            foreach ($_REQUEST['departments_ids'] as $department_id){
                fn_delete_department($department_id);
            }
        }
        $suffix = '.manage_departments';
    }

return [CONTROLLER_STATUS_OK, 'departments' . $suffix];
}

if($mode === 'add_department' || $mode === 'update_department') { 

    $department_id = !empty($_REQUEST['department_id']) ? $_REQUEST['department_id'] : 0;
    $department_data = fn_get_department_data($department_id, DESCR_SL);

    if (empty($department_data) && $mode === 'update_department') {
        return [(CONTROLLER_STATUS_NO_PAGE)];
    }

    Tygh::$app['view']->assign([
        'department_data' => $department_data,
        'u_info' => !empty ($department_data['user_id']) ? fn_get_user_short_info($department_data['user_id']) : [],
    ]);

} elseif ($mode === 'manage_departments' ) {

    list($departments, $search) = fn_get_departments($_REQUEST, $items_per_page = 10, DESCR_SL);

    Tygh::$app['view']->assign('departments', $departments);
    Tygh::$app['view']->assign('search', $search);
    
} elseif ($mode === 'picker') {

    $params = $_REQUEST;
    $params['user_type'] = UserTypes::ADMIN;

    list($users, $search) = fn_get_users($params, $auth, Registry::get('settings.Appearance.admin_elements_per_page'));

    Tygh::$app['view']->assign(['users' => $users, 'user_type' => $user_type]);
    Tygh::$app['view']->display('pickers/users/picker_contents.tpl');
    exit;
} 
 