locals {
# roles list to refer    
  roles = {
    admin        = "admin"
    user         = "user"
    observer     = "observer"
    limited      = "limited_user"
    read_only    = "read_only_user"
    restricted   = "restricted_access"
  }

# timezone list to refer
  time_zone = {
    asia           = "Asia/Singapore"
    europe         = "Europe/Berlin"
  }

# team list to refer
  team_names = {
    CI_GLOB_Observability_Operations         = "P2Y8PGM"
    Global_Observability_and_Quality_TEST    = "P2Y8PGM"
  }

# Build a map of team ID -> team name
  team_map = {
    for team in data.pagerduty_teams.all_teams.teams :
    team.id => team.name
  }

 #Add Users here
  add_users = {
    "naveen_singla" = {
      name      = "Naveen Singla"
      email     = "Naveen.singla@avaloq.com"
      role      = local.roles.admin
      time_zone = local.time_zone.asia
      job_title = "Cloud & Observability Engineer"
      # teams = [local.team_names.CI_GLOB_Observability_Operations]
      teams = [pagerduty_team.teams["CI_GLOB_Observability_Operations"].id]
    }
    "sajeer_kandi" = {
      name  = "Sajeer Kandi"
      email = "Sajeer.Kandi@avaloq.com"
      role      = local.roles.read_only
      time_zone = local.time_zone.asia
      job_title = "DevOps Engineer"
    }
    #Team DL as user for email alert notification for less critical alert
    "CI_GLOB_Observability_Operations" = {
      name      = "CI.GLOB-Observability Operations"
      email     = "Observability@avaloq.com"
      role      = local.roles.read_only
      time_zone = local.time_zone.europe
      job_title = ""
    }
    # Add more users here
  }

# Create Teams here
  add_teams = {
    "CI_GLOB_Observability_Operations" = {
      name        = "CI.GLOB-Observability Operations"
      description = "Global Observability Operation Team"
    }
    # Add more Teams here
  }

# To associate user with team
  user_team_memberships = flatten([
    for username, user in local.add_users : [
    #   for team_id in user.teams : {
      for team_id in lookup(user, "teams", []) : {
        user_key = username
        team_id  = team_id
      }
    ]
  ])

}