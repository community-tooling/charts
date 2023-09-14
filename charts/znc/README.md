# znc

![Version: 1.0.2](https://img.shields.io/badge/Version-1.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Installs ZNC (an IRC bouncer) to your cluster

:warning: Ingress does not support TLS termination yet. Therefore, this chart does not yet provide any ability to expose the IRC TLS port. This will follow in an upcoming version.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| morremeyer | <charts@mor.re> |  |

## TCP port access

As Ingress resources don’t support TCP (yet?), you'll need to define your own way of forwarding traffic to the ZNC pod.

If you use ingress-nginx with the official helm chart, you can use the [tcp services](https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml#L884-L888) as follows:

```
tcp:
  6697: "default/example-tcp-svc:9000"
```

## Creating the initial password

You need to supply an initial password for the initial user (default name `admin`).

To create the password, you need to run `znc --makepass`. You can do this any way you like, one example is shown below

```
# Start the ZNC docker container
docker run --rm -it --entrypoint /bin/sh znc:1.8.2

# Run the 'znc --makeconf' command
/bin/su znc -s /bin/sh -c '/opt/znc/bin/znc --makepass'

# Now copy the values printed to stdout and paste them into your values. See the documentation of the 'config' key for details.
```

:information_source: This password is the initial password. If you change it in the web interface later, it won't be overridden.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| config.hash | string | `nil` | The hash for your initial password' |
| config.method | string | `"sha256"` | The method for your initial password' |
| config.salt | string | `nil` | The salt for your initial password' |
| config.user | string | `"admin"` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"znc"` |  |
| image.tag | string | `"1.8.2"` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` | The ingressClassName for this Ingress resource |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| persistence.enabled | bool | `true` |  |
| persistence.storage | string | `"1Gi"` |  |
| persistence.storageClassName | string | `nil` | Set a storageClassName, otherwise the default class is used. |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.httpPort | int | `80` |  |
| service.ircPort | int | `6697` |  |
| service.type | string | `"ClusterIP"` |  |
| tolerations | list | `[]` |  |
