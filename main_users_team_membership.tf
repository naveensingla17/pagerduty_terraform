# Create a PagerDuty user
# resource "pagerduty_user" "Sajeer_Kandi_STR_001" {
  # name  = "Sajeer Kandi"
  # email = "Sajeer.Kandi@avaloq.com"
  # role      = local.roles.read_only
  # time_zone = "Asia/Singapore"
#   lifecycle {
#     ignore_changes        = [
#       role
#     ]
#   }
# }

# resource "pagerduty_user" "Naveen_Singla_OBS_001" {
#   name      = "Naveen Singla"
#   email     = "Naveen.singla@avaloq.com"
#   role      = local.roles.admin
#   time_zone = "Asia/Singapore"
#   job_title = "Cloud & Observability Engineer"
#   lifecycle {
#     ignore_changes        = [
#       job_title
#     ]
#   }  
# }

# Add users define in local.tf
resource "pagerduty_user" "add_pagerduty_user" {
  for_each  = local.add_users

  name      = each.value.name
  email     = each.value.email
  role      = each.value.role
  time_zone = each.value.time_zone
  job_title = each.value.job_title

  lifecycle {
    ignore_changes = [role,job_title]
  }
}

resource "pagerduty_team_membership" "memberships" {
  for_each = {
    for i, membership in local.user_team_memberships :
    "${membership.user_key}-${membership.team_id}" => membership
  }

  user_id = pagerduty_user.add_pagerduty_user[each.value.user_key].id
  team_id = each.value.team_id
}


# # Team membership (assign user to team)
# resource "pagerduty_team_membership" "naveen_singla_team_obs_001" {
#   user_id = pagerduty_user.Naveen_Singla_OBS_001.id
#   team_id = "P2Y8PGM"  # Team ID for "Global Observability and Quality - TEST"
# }

#Team DL as user for email alert notification for less critical alert
resource "pagerduty_user" "CI_GLOB_Observability_Operations" {
  name      = "CI.GLOB-Observability Operations"
  email     = "Observability@avaloq.com"
  role      = local.roles.read_only
  time_zone = "Europe/Berlin"
}

resource "pagerduty_team" "CI_GLOB_Observability_Operations" {
  name        = "CI.GLOB-Observability Operations"
  description = "Global Observability Operation Team"
}