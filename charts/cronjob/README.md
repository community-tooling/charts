# cronjob

![Version: 4.3.0](https://img.shields.io/badge/Version-4.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Run jobs on a schedule

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| morremeyer |  |  |
| ekeih |  |  |

## Upgrades

For upgrade instructions for breaking changes, see [UPGRADING.md](UPGRADING.md).

## Complex values

### env

You can set environment variables directly with:

```yaml
env:
  ENV_VARIABLE_NAME: "value"
```

### envFrom

This enables you to load a complete ConfigMap or Secret into the env.

```yaml
envFrom:
  - configMapRef:
      name: special-config
```

### envValueFrom

This enables a simplified syntax to set envirnoment variables from a ConfigMap or Secret:

```yaml
envValueFrom:
  USER:
    secretKeyRef:
      name: secret-name
      key: user
```

### configMap

If you want to pass yaml as a value, you need to specify it in block style:

```yaml
configMap:
  enabled: true
  data:
    config.yml: |
      foo: bar
      map:
        list:
          - foo
          - bar
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalVolumeMounts | list | `[]` |  |
| additionalVolumes | list | `[]` |  |
| affinity | object | `{}` | affinity object for the pod |
| annotations | object | `{}` |  |
| apiAccess | object | `{"clusterRoleRules":[],"enabled":false,"roleRules":[],"rules":[]}` | Configuration for access to the Kubernetes API |
| apiAccess.clusterRoleRules | list | `[]` | Rules for the ClusterRole the the pods are bound to. Check [the documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole) for more information |
| apiAccess.enabled | bool | `false` | DEPRECATED, this is automatically detected by checking if `roleRules` or `clusterRoleRules` are configured. If only `rules` are set, this can be set to false to prevent deployment of the Role and RoleBinding (backwards compatibility). |
| apiAccess.roleRules | list | `[]` | Rules for the Role the the pods are bound to. Check [the documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole) for more information |
| apiAccess.rules | list | `[]` | DEPRECATED, use roleRules. Rules for the API access of the ServiceAccount used by the CronJob pods. Check [the documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole) for more information |
| args | list | `[]` | arguments to pass to the command or binary being run |
| automountServiceAccountToken | string | `nil` | Whether to mount a serviceaccount token in the pod. Defaults to true unless `serviceAccount.create=false`. |
| backoffLimit | int | `6` | how many times a job should be re-attempted when the command fails. |
| command | list | `[]` | the command or binary to run |
| commonLabels | object | `{}` | extra labels applied to all resources |
| concurrencyPolicy | string | `"Allow"` | The [concurrencyPolicy](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#concurrency-policy) for the CronJob |
| configMap.data | object | `{}` | The data for the ConfigMap. Both keys and values need to be strings. |
| configMap.defaultMode | string | `nil` | Set the `defaultMode` for the files in the directory. |
| configMap.enabled | bool | `false` | If a ConfigMap with configurable values should be created |
| configMap.mountFiles | list | `[]` | Mounting of individual keys in the ConfigMap as files |
| configMap.mountPath | string | `""` | If specified, the ConfigMap is mounted as a directory at this path |
| dnsConfig | object | `{}` | Optional DNS settings |
| dnsPolicy | string | `nil` | Defaults to "ClusterFirst" if hostNetwork is false and "ClusterFirstWithHostNet" if hostNetwork is true. |
| env | list | `[]` | Directly set environment variables |
| envFrom | list | `[]` | Directly set envFrom config |
| envValueFrom | object | `{}` | Set environment variables from configMaps or Secrets |
| failedJobsHistoryLimit | int | `1` | The number of failed finished jobs to retain. https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#jobs-history-limits |
| fullnameOverride | string | `""` |  |
| hostAliases | list | `[]` | [Host Aliases](https://kubernetes.io/docs/tasks/network/customize-hosts-file-for-pods/#adding-additional-entries-with-hostaliases) |
| hostNetwork | bool | `false` | Set to true to enable host networking |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"alpine"` |  |
| image.tag | string | `"3.23.0"` |  |
| imagePullSecrets | list | `[]` | pull secrets for the specified image |
| initContainers | list | `[]` | initContainers to use. Requires a list of valid container specs. |
| labels | object | `{}` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | nodeSelector object for the pod |
| persistence.enabled | bool | `false` |  |
| persistence.existingVolume | string | `""` | To use an existing PersistentVolume resource, set its name here |
| persistence.mountPath | string | `"/data"` | Where the persistent volume is mounted |
| persistence.storage | string | `"1Gi"` | the amount of space to require for the volume |
| persistence.storageClassName | string | `nil` | Set a storageClassName, otherwise the default class is used. |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` | Pod-level security settings. If podSecurityStandard is set, podSecurityContext overrides those defaults. |
| podSecurityStandard | string | `nil` | Set to `restricted` to set secure defaults for podSecurityContext and securityContext. See https://kubernetes.io/docs/concepts/security/pod-security-standards/ |
| resources | object | `{}` | requests and limits for the container |
| restartPolicy | string | `"OnFailure"` | if the Job should restart when the command fails |
| schedule | string | `"17 3 * * *"` | schedule for the cronjob. |
| securityContext | object | `{}` | Container-level security settings. If podSecurityStandard is set, securityContext overrides those defaults. |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| successfulJobsHistoryLimit | int | `3` | The number of successful finished jobs to retain. https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#jobs-history-limits |
| suspend | bool | `false` | if the job should be suspended |
| tolerations | list | `[]` | List of tolerations for the pod |
