{ selector :
    ./io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector.dhall sha256:42d27b2708fa26aff105ab514c1d2db674891c9f9cdee0850e0d647435aeddb7
, template :
    ./io.k8s.api.core.v1.PodTemplateSpec.dhall sha256:8eea21c0ace52dd3f671f41d6de30abdfb10ba05bf0b44f571472a6a6d689b1f
, minReadySeconds : Optional Natural
, revisionHistoryLimit : Optional Natural
, updateStrategy :
    Optional
      ./io.k8s.api.apps.v1.DaemonSetUpdateStrategy.dhall sha256:a395db54fa6333208b403ea5119ee6abf547f4bdc921c3e412e36ed47f619828
}
