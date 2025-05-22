### test connection with sandbox pagerduty
data "pagerduty_user" "Naveen_Singla" {
  email = "naveen.singla@avaloq.com"
}

# Get all PagerDuty users
data "pagerduty_users" "all_users" {}


# Get all teams
data "pagerduty_teams" "all_teams" {}