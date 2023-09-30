# hcloud-csi-driver

![Version: 3.0.0](https://img.shields.io/badge/Version-3.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.5.1](https://img.shields.io/badge/AppVersion-2.5.1-informational?style=flat-square)

> **:exclamation: This Helm Chart is deprecated!**

:exclamation: This Helm Chart is deprecated!**

There is now an upstream chart, so this chart will no longer be updated.
Old versions be still be available, but the source will be removed after 2023-12-31.

Please migrate to the upstream chart at [hetznercloud/csi-driver](https://github.com/hetznercloud/csi-driver/tree/main/chart).

To use the default values from this chart, use the following values with `hetznercloud/csi-driver`:

```yaml
storageClasses:
  - name: hcloud-volumes
    defaultStorageClass: true
    reclaimPolicy: Retain

metrics:
  enabled: true
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| reclaimPolicy | string | `"Retain"` | The reclaimPolicy for the volume. Must be Retain (keep PV after PVC is deleted) or Delete (delete PV when PVC is deleted) |
