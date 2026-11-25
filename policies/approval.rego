package plrl.stack

# Approval fails unless the merged plan lists every unit. An empty planJson
# has no resource_changes, so this denies runs from a harness that only
# stored the text summary.

required_addresses := {
	"app.local_file.app",
	"network.local_file.network",
	"nested/storage.local_file.storage",
}

deny[{"msg": sprintf("structured plan is missing %s", [address])}] if {
	input.stage == "approval"
	some address in required_addresses
	not unit_present(address)
}

unit_present(address) if {
	some rc in input.plan.resource_changes
	rc.address == address
	rc.type == "local_file"
}

app_marks_demo if {
	some rc in input.plan.resource_changes
	rc.address == "app.local_file.app"
	contains(rc.change.after.content, "run-all demo")
}

deny[{"msg": "app plan does not contain the run-all demo content"}] if {
	input.stage == "approval"
	not app_marks_demo
}
