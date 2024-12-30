{{/*
Expand the name of the chart.
*/}}
{{- define "cronjob.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cronjob.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cronjob.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cronjob.labels" -}}
helm.sh/chart: {{ include "cronjob.chart" . }}
{{ include "cronjob.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml .  }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cronjob.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cronjob.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cronjob.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cronjob.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate the podSecurityContext based on the podSecurityStandard
*/}}
{{- define "cronjob.podSecurityContext" -}}
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
{{- define "cronjob.securityContext" -}}
{{- if eq .Values.podSecurityStandard "restricted" }}
{{- $psc := dict "privileged" false "allowPrivilegeEscalation" false "capabilities" (dict "drop" (list "ALL")) -}}
{{- mustMerge $psc .Values.securityContext | toYaml }}
{{- else }}
{{- .Values.securityContext | toYaml }}
{{- end }}
{{- end }}
