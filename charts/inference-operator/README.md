# inference-operator

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for Kubernetes Inference Operator

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| morremeyer |  |  |
| ekeih |  |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| crds.create | bool | `true` |  |
| inference_service_gateway | string | `"some-gateway-name"` |  |
| inference_service_hostname | string | `"some-hostname"` |  |
| kurator_r2_bucket | string | `"some-r2-bucket"` |  |
| kurator_s3_bucket | string | `"some-s3-bucket"` |  |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.httpGet.path | string | `"/healthz"` |  |
| livenessProbe.httpGet.port | int | `8080` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `5` |  |
| rbac.create | bool | `true` |  |
| resources.limits.cpu | string | `"200m"` |  |
| resources.limits.memory | string | `"1024Mi"` |  |
| resources.requests.cpu | string | `"100m"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| service.nodePort | int | `30036` |  |
| service.port | int | `8000` |  |
| service.targetPort | int | `8080` |  |
| service.type | string | `"NodePort"` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `"inference-operator"` |  |

