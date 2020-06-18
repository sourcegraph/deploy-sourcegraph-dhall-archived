{ selector :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall sha256:42d27b2708fa26aff105ab514c1d2db674891c9f9cdee0850e0d647435aeddb7
, template :
    ./io.k8s.api.core.v1.PodTemplateSpec.dhall sha256:8eea21c0ace52dd3f671f41d6de30abdfb10ba05bf0b44f571472a6a6d689b1f
, minReadySeconds : Optional Natural
, paused : Optional Bool
, progressDeadlineSeconds : Optional Natural
, replicas : Optional Natural
, revisionHistoryLimit : Optional Natural
, strategy :
    Optional
      ./io.k8s.api.apps.v1.DeploymentStrategy.dhall sha256:b08c56c88f023d2b4e0ed8947c3396d33c29984fb31b4cf22ae56ed661cc031a
}
