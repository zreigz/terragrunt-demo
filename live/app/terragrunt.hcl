include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "network" {
  config_path = "../network"

  mock_outputs = {
    name = "network"
  }
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
}

inputs = {
  network_name = dependency.network.outputs.name
}
