# Terragrunt parent-folder demo

`live/` is a parent folder of three Terragrunt units. The parent itself has no `terragrunt.hcl`.

- `live/network` writes a stable local file.
- `live/app` depends on `network`.
- `live/nested/storage` is one level deeper and also stable.

Each unit uses the `hashicorp/local` provider and its own local backend, so plan and apply need no cloud account.

Point a Plural stack at this repo with:

```yaml
apiVersion: deployments.plural.sh/v1alpha1
kind: InfrastructureStack
metadata:
  name: terragrunt-demo
spec:
  type: TERRAGRUNT
  manageState: false
  git:
    ref: main
    folder: live
  configuration:
    terragrunt:
      runAll: true
```

From `live/`, after the harness change:

1. `terragrunt run --all --non-interactive --queue-exclude-external plan` proposes all three units.
2. Apply, then plan again with no edits. Every unit is a no-op, which is the skip-apply case.
3. Change the content string in `live/app/main.tf`. The next plan changes `app` and leaves `network` and `nested/storage` empty.
