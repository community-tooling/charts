# kube-prometheus-stack-crds

![Version: 61.3.1](https://img.shields.io/badge/Version-61.3.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Deploys the kube-prometheus-stack CRDs to your cluster

This chart is released in lockstep with [kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack).

If you install this chart to your cluster first and then the matching kube-prometheus-stack version, compatibility is guaranteed.

If you use renovate, we recommend using the config below to group together updates of kube-prometheus-stack and kube-prometheus-stack-crds.

```json
{
  "packageRules": [
    {
      "matchPackageNames": [
        "kube-prometheus-stack",
        "kube-prometheus-stack-crds"
      ],
      "groupName": "kube-prometheus-stack"
    }
  ]
}
```

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| morremeyer |  |  |
| ekeih |  |  |

