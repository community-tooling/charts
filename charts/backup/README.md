# backup

![Version: 3.4.0](https://img.shields.io/badge/Version-3.4.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Chart to back up PVCs with restic and regularly clean up the snapshots.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| morremeyer |  |  |
| ekeih |  |  |

## Upgrades

For upgrade instructions for breaking changes, see [UPGRADING.md](UPGRADING.md).

## Usage

If you want to regularly back up the contents of a PVC, use this minimal example for your values.yaml

```yaml
pvc: name-of-pvc
repo: s3:https://minio.example.com/name-of-pvc
backupJob:
  affinityLabels:
    app.kubernetes.io/instance: morre-paperless
    app.kubernetes.io/name: paperless
```

This will back up every day at 03:17. At 15:17, a cleanup will run and keep:

* 8 daily snapshots
* 5 weekly snapshots
* 13 monthly snapshots
* 2 yearly snapshots

For more advanced use cases, check the configuration section below or the values.yaml file.

## Configuration

The following table lists the configurable parameters of the chart and the default values.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| backupJob.additionalVolumes | list | `[]` | Additional volumes to add to the pod, e.g. to backup hostPaths. |
| backupJob.affinity | object | `{}` | to specify a full `spec.affinity` map for a pod. In most cases, `backupJob.affinityLabels` will be sufficient. |
| backupJob.affinityLabels | object | `{}` | labels of a pod that a strict affinity for scheduling will be set to. Needed for `ReadWriteOnce` PVCs. |
| backupJob.backup.additionalVolumeMounts | list | `[]` | Additional volumes to mount to the restic container, e.g. to backup hostPaths. |
| backupJob.backup.args | list | `[]` | arguments for the backup. **Automatically generated, only set when necessary** |
| backupJob.backup.command | string | `nil` | command for the backup. Defaults to '/usr/bin/restic' by the upstream container. |
| backupJob.backup.image.pullPolicy | string | `"IfNotPresent"` |  |
| backupJob.backup.image.repository | string | `"restic/restic"` |  |
| backupJob.backup.image.tag | string | `"0.17.3"` |  |
| backupJob.backup.resources | object | `{}` | resources for the backup container |
| backupJob.backup.resticGlobalExtraArgs | list | `[]` | arguments that are passed to backup restic command as global flag |
| backupJob.concurrencyPolicy | string | `"Forbid"` | concurrencyPolicy for the backup Jobs |
| backupJob.env | list | `[]` | Additional environment values to load. Only applies to the backup container, not the init containers that initializes the restic repository. Has to match the pod.spec.containers.env spec. |
| backupJob.failedJobsHistoryLimit | int | `1` | failedJobsHistoryLimit for the backup Jobs |
| backupJob.init | object | `{"image":{"pullPolicy":"IfNotPresent","repository":"restic/restic","tag":"0.17.3"},"resources":{}}` | Configuration for the repository init container |
| backupJob.init.resources | object | `{}` | resources for the init container |
| backupJob.nodeSelector | object | `{}` |  |
| backupJob.schedule | string | `"17 3 * * *"` | when to run backups |
| backupJob.securityContext | object | `{}` |  |
| backupJob.successfulJobsHistoryLimit | int | `3` | successfulJobsHistoryLimit for the backup Jobs |
| backupJob.tolerations | list | `[]` |  |
| cleanupJob.additionalVolumeMounts | list | `[]` | Additional volumes to mount to the restic container, e.g. to backup hostPaths. |
| cleanupJob.affinity | object | `{}` |  |
| cleanupJob.args | list | `[]` | arguments for the cleanup. **Automatically generated, only set when necessary** |
| cleanupJob.command | string | `nil` | command for the cleanup. Defaults to '/usr/bin/restic' by the upstream container. |
| cleanupJob.concurrencyPolicy | string | `"Forbid"` | concurrencyPolicy for the cleanup Jobs |
| cleanupJob.enabled | bool | `true` | If backups shall be cleaned up after some time |
| cleanupJob.failedJobsHistoryLimit | int | `1` | failedJobsHistoryLimit for the cleanup Jobs |
| cleanupJob.image.pullPolicy | string | `"IfNotPresent"` |  |
| cleanupJob.image.repository | string | `"restic/restic"` |  |
| cleanupJob.image.tag | string | `"0.17.3"` |  |
| cleanupJob.keepDaily | int | `8` | number of daily snapshots to keep |
| cleanupJob.keepMonthly | int | `13` | number of monthly snapshots to keep |
| cleanupJob.keepWeekly | int | `5` | number of weekly snapshots to keep |
| cleanupJob.keepYearly | int | `2` | number of yearly snapshots to keep |
| cleanupJob.nodeSelector | object | `{}` |  |
| cleanupJob.resources | object | `{}` | resources for the cleanup container |
| cleanupJob.schedule | string | `"17 15 * * *"` | when to run the cleanup |
| cleanupJob.securityContext | object | `{}` |  |
| cleanupJob.successfulJobsHistoryLimit | int | `3` | successfulJobsHistoryLimit for the cleanup Jobs |
| cleanupJob.tolerations | list | `[]` |  |
| compression | string | `nil` | compression mode (only available for repository format version 2), one of (auto|off|max) |
| exclude | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| nameOverride | string | `""` |  |
| pvc | string | `nil` |  |
| repo | string | `nil` | The repository location |
| secretName | string | `"backup-secret"` | The secret that all containers load their environment from. See https://restic.readthedocs.io/en/latest/040_backup.html#environment-variables for variables. |
| sftpConfig.knownHosts | list | `[]` | Deployed as ConfigMap and mounted to /etc/ssh/ssh_known_hosts |
| sftpConfig.privateKeys.existingSecret | string | `nil` | Mounted to /root/.ssh/ |
