package accesscontrol

default allow = false

roles_permissions = {
    "owner": {"user_storage": ["read", "create", "update", "delete"], "points_ledger": ["read", "update"], "logs": ["read"]},
    "manager": {"user_storage": ["read", "create", "update"], "points_ledger": ["read", "update"], "logs": ["read"]},
    "engineer": {"user_storage": ["read"], "points_ledger": ["read"], "logs": ["read"]},
    "product_manager": {"user_storage": ["read_non_admins"], "points_ledger": ["read"], "logs": ["none"]}
}

maker_checker = {
    "update_points_balance": {"maker": "product_manager", "checker": ["owner"]},
    "update_user_details": {"maker": "engineer", "checker": ["manager", "owner"]}
}

can_perform_action_as_maker(action, user) {
    role := user.role
    action_info := maker_checker[action]
    role == action_info.maker
}

can_perform_action_as_checker(action, user) {
    role := user.role
    action_info := maker_checker[action]
    checker_roles := action_info.checker
    role == checker_roles[_]
}

allow {
    input.action
    input.user
    can_perform_action_as_maker(input.action, input.user)
}

allow {
    input.action
    input.user
    can_perform_action_as_checker(input.action, input.user)
}
