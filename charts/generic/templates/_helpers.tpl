{{/*
Expand the name of the chart.
*/}}
{{- define "generic.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "generic.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "generic.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "generic.labels" -}}
helm.sh/chart: {{ include "generic.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/version: {{ .Values.image.tag | toString | mustRegexFind "[a-zA-Z0-9-_.]+$" | trunc 63 | quote }}
{{ include "generic.selectorLabels" . }}
{{- with .Values.labels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "generic.selectorLabels" -}}
app.kubernetes.io/name: {{ include "generic.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Pod labels
*/}}
{{- define "generic.podLabels" -}}
{{ include "generic.selectorLabels" . }}
{{- with .Values.podLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "generic.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "generic.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate the podSecurityContext based on the podSecurityStandard
*/}}
{{- define "generic.podSecurityContext" -}}
{{- if eq .Values.podSecurityStandard "restricted" }}
{{- $sc := dict "runAsNonRoot" true "seccompProfile" (dict "type" "RuntimeDefault") "fsGroup" 1000 "fsGroupChangePolicy" "OnRootMismatch" -}}
{{- mustMerge $sc .Values.podSecurityContext | toYaml }}
{{- else }}
{{- .Values.podSecurityContext | toYaml }}
{{- end }}
{{- end }}

{{/*
Generate the securityContext based on the podSecurityStandard
*/}}
{{- define "generic.securityContext" -}}
{{- if eq .Values.podSecurityStandard "restricted" }}
{{- $psc := dict "privileged" false "allowPrivilegeEscalation" false "capabilities" (dict "drop" (list "ALL")) -}}
{{- mustMerge $psc .Values.securityContext | toYaml }}
{{- else }}
{{- .Values.securityContext | toYaml }}
{{- end }}
{{- end }}
