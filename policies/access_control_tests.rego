package accesscontrol

test_users = {
    "alice": {"role": "owner"},
    "bob": {"role": "manager"},
    "carol": {"role": "engineer"},
    "dave": {"role": "product_manager"}
}

test_can_perform_update_points_balance_positive {
    can_perform_action_as_maker("update_points_balance", test_users["dave"])
}

test_can_perform_update_points_balance_negative {
    not can_perform_action_as_maker("update_points_balance", test_users["carol"])
}

test_can_perform_update_user_details_positive {
    can_perform_action_as_maker("update_user_details", test_users["carol"])
}

test_can_perform_update_user_details_negative {
    not can_perform_action_as_maker("update_user_details", test_users["dave"])
}

test_can_perform_update_user_details_checker_positive {
    can_perform_action_as_checker("update_user_details", test_users["bob"])
}

test_can_perform_update_user_details_checker_negative {
    not can_perform_action_as_checker("update_user_details", test_users["carol"])
}

test_allow_update_points_balance {
    allow with input as {"action": "update_points_balance", "user": test_users["dave"]}
}

test_deny_update_points_balance {
    not allow with input as {"action": "update_points_balance", "user": test_users["alice"]}
}

test_allow_update_user_details {
    allow with input as {"action": "update_user_details", "user": test_users["carol"]}
}

test_deny_update_user_details {
    not allow with input as {"action": "update_user_details", "user": test_users["bob"]}
}

