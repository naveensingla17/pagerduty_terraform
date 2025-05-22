# Add Teams define in local.tf "add_teams"
resource "pagerduty_team" "teams" {
  for_each = local.add_teams
  name        = each.value.name
  description = each.value.description
}

# Add Users define in local.tf "add_users"
resource "pagerduty_user" "add_pagerduty_user" {
  for_each  = local.add_users

  name      = each.value.name
  email     = lower(each.value.email)
  role      = each.value.role
  time_zone = each.value.time_zone
  job_title = lookup(each.value, "job_title", "")

  lifecycle {
    ignore_changes = [role,job_title]
  }
}

# Associate teams define in local.tf under "add_users"
resource "pagerduty_team_membership" "memberships" {
  for_each = {
    for i, membership in local.user_team_memberships :
    "${membership.user_key}-${membership.team_id}" => membership
  }

  user_id = pagerduty_user.add_pagerduty_user[each.value.user_key].id
  team_id = each.value.team_id
}
