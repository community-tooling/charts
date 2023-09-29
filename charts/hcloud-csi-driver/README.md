# hcloud-csi-driver

![Version: 2.5.1](https://img.shields.io/badge/Version-2.5.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.5.1](https://img.shields.io/badge/AppVersion-2.5.1-informational?style=flat-square)

Deploys the hcloud-csi-driver

**Homepage:** <https://github.com/morremeyer/charts>
## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| morremeyer |  |  |
| ekeih |  |  |
## Source Code

* <https://github.com/hetznercloud/csi-driver>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| reclaimPolicy | string | `"Retain"` | The reclaimPolicy for the volume. Must be Retain (keep PV after PVC is deleted) or Delete (delete PV when PVC is deleted) |
