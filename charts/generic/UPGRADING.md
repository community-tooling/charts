# Upgrading

## 8.1.3 to 9.0.0

This release removes the default `-generic` suffix for generated resources.
While this suffix makes sense for purpose-built helm charts, for this generic chart, it does not, since the suffix does not contain any information.

### Migration

**If you have set `fullnameOverride`**

No migration is needed. However, if you have set `fullnameOverride` to the helm release name, you can remove it, since that is now the default behavior.

**All other cases**

To keep all resources as they are, set `fullnameOverride` to `{name of the release}-generic`.

If you decide to delete and re-create the resources, keep in mind that the PVC will also be deleted and you'll need to ensure the data is backed up and restored appropriately.

## 7.7.0 to 8.0.0

If you are using the default ServiceAccount (which is generally discouraged) you must explicitly set `automountServiceAccountToken: true` now to match the behavior from 7.7.0.

You should consider creating a dedicated ServiceAccount for your Deployment which automatically sets `automountServiceAccountToken: true`.

## 6.1.0 to 7.0.0

Version 7.0.0 breaks compatibility for Kubernetes versions < 1.23.
If you still run on 1.22 or older, you need to upgrade to 1.23 or newer.

## 5.6.0 to 6.0.0

With this release, a `PodAntiAffinity` is deployed by default, spreading pods across nodes. This is configurable with the `enableNodeSpreadPodAntiAffinity` value.

The release also introduces a `enableZoneSpreadPodAntiAffinity` value, which is disabled by default. When you enable it, pods will also be spread across zones by the `topology.kubernetes.io/zone` topology key.

**If you do not use the `affinity` value, no changes are needed.**

If you do use the `affinity` value **and** you do have `podAntiAffinity` terms that are `preferredDuringSchedulingIgnoredDuringExecution`, you need to migrate your configuration as follows.

All other affinities can stay in the `affinity` value. If you specify any PodAntiAffinities that are `preferredDuringSchedulingIgnoredDuringExecution` in the `affinity` value, the default and additional policies specified will be overwritten.

Migration example:

_Old_:

```yaml
affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 50
        podAffinityTerm:
          labelSelector:
            matchLabels:
              app.kubernetes.io/component: app
              app.kubernetes.io/name: nextcloud
          topologyKey: topology.kubernetes.io/zone
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              app.kubernetes.io/component: app
              app.kubernetes.io/name: nextcloud
          topologyKey: kubernetes.io/hostname
      - weight: 70
        podAffinityTerm:
          labelSelector:
            matchLabels:
              app.kubernetes.io/component: some-other-component
              app.kubernetes.io/name: nextcloud
          topologyKey: kubernetes.io/hostname
```

_New_:

With this, the zone and node distribution are handled by enabling both default policies.
Then, the additional PodAntiAffinity is migrated to `additionalPreferredPodAntiAffinity`.

```yaml
enableZoneSpreadPodAntiAffinity: true

additionalPreferredPodAntiAffinity:
  - weight: 70
    podAffinityTerm:
      labelSelector:
        matchLabels:
          app.kubernetes.io/component: some-other-component
          app.kubernetes.io/name: nextcloud
      topologyKey: kubernetes.io/hostname
```

## 3.8.0 to 5.0.0

You must now set the `ingress.hosts[*].paths[*].servicePortName`. As with 4.0.0, all ports must be configured explicitly,
therefore it is a deliberate change that you cannot set a service port number for an Ingress resource: Naming ports is a good practice.

The `servicePortName` must be set to an `service.ports[*].name` to work.

**If you do not use an Ingress, you do not need to do anything**

Migration example:

_Old_:

```yaml
service:
  targetPort: http
  protocol: TCP
  name: http
  port: 80

ingress:
  enabled: true
  hosts:
    - host: example.com
      paths:
        - path: /
```

_New_:

```yaml
service:
  ports:
    - targetPort: http
      protocol: TCP
      name: http
      port: 80

ingress:
  enabled: true
  hosts:
    - host: example.com
      paths:
        - path: /
          # The servicePortName must be set now
          servicePortName: http
```

## 3.8.0 to 4.0.0

:warning: Release 4.0.0 has a configuration-breaking bug when using `ingress: true`. Please upgrade to 5.0.0 directly.

### Kubernetes Version

If you set `ingress.enabled: true`, this chart is only compatible with Kubernetes 1.21 and newer.

### Service Ports

The port configuration for the `service` key has been deprecated with `3.6.0` and is now removed.

**If you did not change the default configuration, you do not need to do anything**

Migration example:

_Old_:

```yaml
service:
  targetPort: http
  protocol: TCP
  name: http
  port: 80
```

_New_:

```yaml
service:
  ports:
    - targetPort: http
      protocol: TCP
      name: http
      port: 80
```

### To 3.0.0

Support for CronJobs has been removed. If you used the `isCronjob: true` flag, please migrate to `morremeyer/cronjob` in version `2.0.0 <= x < 3.0.0`.

:warning: If you need open ports on your CronJob pod, this is not supported in the cronjob chart. This is a design decision as CronJobs should not have any incoming traffic.

The cronjob chart is almost fully compatible with all existing configuration you have (except for `ports`), you just have to do one migration step:

1. Remove the `isCronjob: true` value

### To 2.0.0

The format for configuration environment variables has changed and is now less verbose.

Old:

```yaml
env:
  - name: ENV_NAME
    value: test
```

New:

```yaml
env:
  ENV_NAME: test
```

If you have environment variables set from ConfigMaps or Secrets, check out `envValueFrom`, which was [added in 1.1.0](https://github.com/morremeyer/charts/commit/a2b767f91b8f921bbd81abcb37648a6724ebb1db).
