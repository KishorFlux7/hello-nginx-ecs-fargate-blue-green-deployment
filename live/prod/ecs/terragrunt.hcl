include "root" {
  path = find_in_parent_folders()
}

dependency "network" {
  config_path = "${get_terragrunt_dir()}/../network"
}

# Indicate where to source the terraform module from.
terraform {
  source = "../../../modules//ecs"
  extra_arguments "common_vars" {
    commands = get_terraform_commands_that_need_vars()

    arguments = [
      "-var-file=./ecs.tfvars"
    ]
  }
}

inputs = {
  public_subnet_ids      = dependency.network.outputs.public_subnet_ids
  private_subnet_ids     = dependency.network.outputs.private_subnet_ids
  vpc_id                 = dependency.network.outputs.vpc_id
}
