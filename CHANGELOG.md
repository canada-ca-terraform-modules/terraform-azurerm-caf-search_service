# Changelog

All notable changes to this module are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## v1.1.0 - 2026-08-10

### Added

- `network_rule_bypass_option` argument on `azurerm_search_service` (Optional; `None` or `AzureServices`).
- `identity_ids` argument on the `identity` block, required when `identity.type` includes `UserAssigned`.
- Optional `name` override (`SearchService.name`) so callers whose real Search Service name diverges from the generated naming formula can pin it without destroy/recreate.
- `providers.tf` pinning `azurerm ~> 5.0` and `required_version >= 1.9`.
- `.tflint.hcl`, `.gitignore`, `.gitattributes`.
- `tests/search_service.tftest.hcl` and `tests/upgrade_compat.tftest.hcl` (mock_provider, no live credentials required).
- `.github/workflows/terraform-ci.yml` (fmt, init, validate, test, tflint on every PR).
- `.github/workflows/release.yml` (creates a GitHub release on merge to `main`, tagged from `ESLZ/searchService.tf`'s own `?ref=`).

### Changed

- Pinned the `private_endpoint` child module ref from `v1.0.1` to `v1.2.0` (already on `azurerm ~> 5.0`, no conflicting constraint).
- `SearchService-object` output marked `sensitive = true` (the resource exposes `primary_key`, `secondary_key`, and `query_keys`).
- Bumped `.github/workflows/documentation.yml` action pins: `actions/checkout` `v4.1.7` -> `v7.0.1`, `terraform-docs/gh-actions` `v1.2.0` -> `v1.4.1`.
- Bumped `ESLZ/searchService.tf` module ref from `v1.0.1` to `v1.1.0`.

### Known blockers

- None. Target `azurerm` provider version `5.0.1` was confirmed by the user; this is a real published release.
