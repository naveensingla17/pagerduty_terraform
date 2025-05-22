# ### Mandatory to display in output to use the escalation policy value in service creation

# output "escalation_policy_ids" {
#   value = {
#     "default"                 = pagerduty_escalation_policy.default.id
#     "l2_escalation"           = pagerduty_escalation_policy.L2_Escalation.id
#     "rbc_l2_escalation"       = pagerduty_escalation_policy.RBC_L2_Escalation.id
#     "l3_escalation"           = pagerduty_escalation_policy.L3_SRE_Escalation.id
#     "l3_sre_uncategorized"    = pagerduty_escalation_policy.L3_SRE_Uncategorized.id
#     "secops_escalation"       = pagerduty_escalation_policy.SecOps_Escalation.id
#     "iron"                    = pagerduty_escalation_policy.Iron.id
#     "obsidian"                = pagerduty_escalation_policy.Obsidian.id
#     "diamond"                 = pagerduty_escalation_policy.Diamond.id
#     "AOC_Compute"             = pagerduty_escalation_policy.AOC_Compute.id
#     "AOC_Storage"             = pagerduty_escalation_policy.AOC_Storage.id
#     "AOC_K8S"                 = pagerduty_escalation_policy.AOC_K8S.id
#     "AOC_Middleware"          = pagerduty_escalation_policy.AOC_Middleware.id
#     "AOC_Database"            = pagerduty_escalation_policy.AOC_Database.id
#     "AOC_Compute_non-prod"    = pagerduty_escalation_policy.AOC_Compute_non-prod.id
#     "AOC_K8S_non-prod"        = pagerduty_escalation_policy.AOC_K8S_non-prod.id
#     "AOC_MIDDLEWARE_non-prod" = pagerduty_escalation_policy.AOC_MIDDLEWARE_non-prod.id
#     "AOC_Database_non-prod"   = pagerduty_escalation_policy.AOC_Database_non-prod.id
#     "To_discard_alerts"       = pagerduty_escalation_policy.To_discard_alerts.id
#     "AMS_L2_Notification"     = pagerduty_escalation_policy.AMS_L2_Notification.id
#   }
# }

# Output all user details
output "all_pagerduty_users" {
  value = {
    for user in data.pagerduty_users.all_users.users : user.name => {
      name = user.name
      id    = user.id
      email = user.email
      role = user.role
      time_zone = user.time_zone
    }
  }
}

# Output all teams details
output "all_pagerduty_teams" {
  value = {
    for team in data.pagerduty_teams.all_teams.teams : team.id => {
      name = team.name
      description = team.description
    }
  }
}
