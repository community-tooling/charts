# generic

![Version: 7.3.2](https://img.shields.io/badge/Version-7.3.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A chart for generic applications. Use this if you need to deploy something without wanting to build a fully fledged new helm chart.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| morremeyer |  |  |
| ekeih |  |  |

## Upgrading

See [the upgrading instructions](UPGRADING.md) for upgrades with breaking changes.

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

### additionalObjects

If you want to add additional objects you can deploy them with `additionalObjects`:

```
additionalObjects:
  - apiVersion: v1
    data:
      custom-key: custom value
    kind: ConfigMap
    metadata:
      name: additional-configmap
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers | list | `[]` | Additional sidecar containers |
| additionalObjects | list | `[]` | Additional API resources to deploy |
| additionalPreferredPodAntiAffinity | object | `{}` | Additional preferredDuringSchedulingIgnoredDuringExecution podAntiAffinity terms |
| additionalVolumeMounts | list | `[]` |  |
| additionalVolumes | list | `[]` |  |
| affinity | object | `{}` | Additional affinity terms. **Do not** specify PodAntiAffinities with preferredDuringSchedulingIgnoredDuringExecution here, these go to `additionalPreferredPodAntiAffinity`. All `requiredDuringScheduling` affinities need to be defined here. |
| annotations | object | `{}` |  |
| args | string | `nil` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| command | string | `nil` |  |
| configMap.data | object | `{}` | The data for the ConfigMap. Both keys and values need to be strings. |
| configMap.enabled | bool | `false` | If a ConfigMap with configurable values should be created |
| configMap.mountFiles | list | `[]` | Mounting of individual keys in the ConfigMap as files |
| configMap.mountPath | string | `""` | If specified, the ConfigMap is mounted as a directory at this path |
| deploymentStrategy | object | `{}` |  |
| dnsConfig | object | `{}` | Optional DNS settings |
| dnsPolicy | string | `nil` | Defaults to "ClusterFirst" if hostNetwork is false and "ClusterFirstWithHostNet" if hostNetwork is true. |
| enableNodeSpreadPodAntiAffinity | bool | `true` | Enable an AntiAffinity between pods, spreading them across nodes if possible with a priority of 100. |
| enableZoneSpreadPodAntiAffinity | bool | `false` | Enable an AntiAffinity between pods, spreading them across zones if possible with a priority of 50. |
| env | list | `[]` | Directly set environment variables |
| envFrom | list | `[]` | Directly set envFrom config |
| envValueFrom | object | `{}` | Set environment variables from configMaps or Secrets |
| fullnameOverride | string | `""` |  |
| hostNetwork | bool | `false` | Set to true to enable host networking |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"nginx"` |  |
| image.tag | string | `"1.25.3"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.additionalLabels | object | `{}` | Additional labels for the ingress resource |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `nil` | The ingressClassName for this Ingress resource |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0] | object | `{"host":"chart-example.local","paths":[{"path":"/","servicePortName":"http"}]}` | host name to listen to |
| ingress.hosts[0].paths[0] | object | `{"path":"/","servicePortName":"http"}` | URL path |
| ingress.hosts[0].paths[0].servicePortName | string | `"http"` | Name of the target port on the service |
| ingress.tls | list | `[]` |  |
| initContainers | list | `[]` |  |
| labels | object | `{}` |  |
| livenessProbe.httpGet | object | `{"path":"/","port":"http"}` | Set `httpGet: ~` to deactivate |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.annotations | object | `{}` | Annotations to add to the PersistentVolumeClaim |
| persistence.enabled | bool | `false` |  |
| persistence.mountPath | string | `"/data"` | Where the persistent volume is mounted |
| persistence.storage | string | `"100Mi"` |  |
| persistence.storageClassName | string | `nil` | Set a storageClassName, otherwise the default class is used. |
| podAnnotations | object | `{}` | annotations to set for the Pods |
| podDisruptionBudget.enabled | bool | `false` | Deploy a PodDisruptionBudget |
| podDisruptionBudget.maxUnavailable | string | `""` | How many pods can be unvailable, maximum |
| podDisruptionBudget.minAvailable | string | `"25%"` | How many pods need to be available, minimum |
| podLabels | object | `{}` | labels to add to the Pods |
| podSecurityContext | object | `{}` |  |
| ports[0].containerPort | int | `80` |  |
| ports[0].name | string | `"http"` |  |
| ports[0].protocol | string | `"TCP"` |  |
| readinessProbe.httpGet | object | `{"path":"/","port":"http"}` | Set `httpGet: ~` to deactivate |
| replicaCount | int | `1` | number of replicas |
| resources | object | `{}` |  |
| restartPolicy | string | `"Always"` |  |
| revisionHistoryLimit | string | `nil` | The number of old ReplicaSets to retain |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.ip | string | `nil` |  |
| service.loadBalancerIP | string | `nil` |  |
| service.ports | list | `[{"name":"http","port":80,"protocol":"TCP","targetPort":"http"}]` | List of ports. If you override it, you will have to explicitly add the default again. |
| service.ports[0] | object | `{"name":"http","port":80,"protocol":"TCP","targetPort":"http"}` | Target port on the pod. |
| service.ports[0].name | string | `"http"` | Name of the port on the service. |
| service.ports[0].port | int | `80` | Port to use on the service. |
| service.ports[0].protocol | string | `"TCP"` | Protocol to use for the target port. |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template. |
| serviceMonitors[0] | object | `{"additionalLabels":{},"enabled":false,"interval":"1m","jobLabel":"","name":"","path":"/metrics","port":"http","scrapeTimeout":"10s"}` | If a ServiceMonitor should be deployed. Needs the CRD installed |
| serviceMonitors[0].additionalLabels | object | `{}` | Additional labels for the ServiceMonitor resource |
| serviceMonitors[0].interval | string | `"1m"` | How often to scrape |
| serviceMonitors[0].jobLabel | string | `""` | The label 'job' in prometheus. Defaults to the release name |
| serviceMonitors[0].name | string | `""` | Name of the resource, defaults to the release name |
| serviceMonitors[0].path | string | `"/metrics"` | The path of the metrics endpoint |
| serviceMonitors[0].port | string | `"http"` | The port to scrape |
| serviceMonitors[0].scrapeTimeout | string | `"10s"` | Timeout for scraping |
| startupProbe | string | `nil` | Configure a startup probe for the pod |
| terminationGracePeriodSeconds | int | `30` | How long the pod may take to terminate before it is killed by the kubelet |
| tolerations | list | `[]` |  |
