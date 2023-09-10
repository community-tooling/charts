# namespaces

![Version: 3.1.1](https://img.shields.io/badge/Version-3.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Deploy namespaces with (default) networkpolicies

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| morremeyer | <charts@mor.re> |  |
| ekeih |  |  |

## Example

```yaml
# Disable all NetworkPolicies
disableNetworkPolicies: false

defaultNetworkPolicies:
  # Deny all egress traffic
  default-policy:
    spec:
      podSelector:
        matchLabels:
          role: db
      policyTypes:
        - Egress

namespaces:
  test:
    labels:
      meta.mor.re/testlabel: hallo
    networkPolicies:
      testpolicy:
        spec:
          podSelector:
            matchLabels:
              role: db

  no-policies:
    disableDefaultNetworkPolicies: true
```

## Upgrading

### To 3.0.0

Previous versions added annotations to all namespaces and network policies to prevent Helm from deleting them when they got removed from the chart release. This release disables that behaviour for network policies. To keep the old behaviour set `keepNetworkPolicies: true`.

### To 2.0.0

The format to define namespaces and network policies has changed. Previously both were specified as a `list` with a `name` key. With this release a `map` is used instead with the name as key. This makes it possible to split the values into several files and merge them with helm.

Old:

```yaml
defaultNetworkPolicies:
  # Deny all egress traffic
  - name: default-policy
    spec:
      podSelector:
        matchLabels:
          role: db
      policyTypes:
        - Egress

namespaces:
  - name: test
    labels:
      meta.mor.re/testlabel: hallo
    networkPolicies:
      - name: testpolicy
        spec:
          podSelector:
            matchLabels:
              role: db
```

New:

```yaml
defaultNetworkPolicies:
  # Deny all egress traffic
  default-policy:
    spec:
      podSelector:
        matchLabels:
          role: db
      policyTypes:
        - Egress

namespaces:
  test:
    labels:
      meta.mor.re/testlabel: hallo
    networkPolicies:
      testpolicy:
        spec:
          podSelector:
            matchLabels:
              role: db
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| defaultNetworkPolicies | object | `{}` | NetworkPolicies that will be applied to all namespaces |
| disableNetworkPolicies | bool | `false` | Switch to disable all NetworkPolicies |
| keepNamespaces | bool | `true` | Configure if namespaces should get deleted when they are removed from the chart release. |
| keepNetworkPolicies | bool | `false` | Configure if NetworkPolicies should get deleted when they are removed from the chart release. |
| namespaces | object | `{}` | List of namespaces to deploy |
