# cronjob

![Version: 3.4.0](https://img.shields.io/badge/Version-3.4.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

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
| apiAccess | object | `{"enabled":false,"rules":[]}` | Configuration for access to the Kubernetes API |
| apiAccess.enabled | bool | `false` | When set to true, a Role and RoleBinding are deployed that give access with the rules defined in apiAccess.rules |
| apiAccess.rules | list | `[]` | Rules for the API access of the ServiceAccount used by the CronJob pods. Check [the documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole) for more information |
| args | list | `[]` | arguments to pass to the command or binary being run |
| command | list | `[]` | the command or binary to run |
| concurrencyPolicy | string | `"Allow"` | The [concurrencyPolicy](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/#concurrency-policy) for the CronJob |
| configMap.data | object | `{}` | The data for the ConfigMap. Both keys and values need to be strings. |
| configMap.enabled | bool | `false` | If a ConfigMap with configurable values should be created |
| configMap.mountFiles | list | `[]` | Mounting of individual keys in the ConfigMap as files |
| configMap.mountPath | string | `""` | If specified, the ConfigMap is mounted as a directory at this path |
| env | list | `[]` | Directly set environment variables |
| envValueFrom | object | `{}` | Set environment variables from configMaps or Secrets |
| failedJobsHistoryLimit | string | `nil` | The number of failed finished jobs to retain. |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"alpine"` |  |
| image.tag | string | `"3.19.1"` |  |
| imagePullSecrets | list | `[]` | pull secrets for the specified image |
| initContainers | list | `[]` | initContainers to use. Requires a list of valid container specs. |
| labels | object | `{}` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | nodeSelector object for the pod |
| persistence.enabled | bool | `false` |  |
| persistence.mountPath | string | `"/data"` | Where the persistent volume is mounted |
| persistence.storage | string | `"1Gi"` | the amount of space to require for the volume |
| persistence.storageClassName | string | `nil` | Set a storageClassName, otherwise the default class is used. |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| resources | object | `{}` | requests and limits for the container |
| restartPolicy | string | `"OnFailure"` | if the Job should restart when the command fails |
| schedule | string | `"17 3 * * *"` | schedule for the cronjob. |
| securityContext | object | `{}` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| successfulJobsHistoryLimit | string | `nil` | The number of successful finished jobs to retain. |
| suspend | bool | `false` | if the job should be suspended |
| tolerations | list | `[]` | List of tolerations for the pod |
