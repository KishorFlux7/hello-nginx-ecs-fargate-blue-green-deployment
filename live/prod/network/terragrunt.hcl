include "root" {
  path = find_in_parent_folders()
}

# Indicate where to source the terraform module from.
terraform {
  source = "../../../modules//network"
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var-file=./network.tfvars"
    ]
  }
}

inputs = {}
