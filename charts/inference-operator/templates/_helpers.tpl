{{- define "inference-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "inference-operator.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "inference-operator.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "inference-operator.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/name: {{ include "inference-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "inference-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "inference-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
