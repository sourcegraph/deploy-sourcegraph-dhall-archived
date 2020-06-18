{ jobTemplate :
    ./io.k8s.api.batch.v1beta1.JobTemplateSpec.dhall sha256:959eee751ac9bdfffce59990061969d2509d4dfdf17fb8201825db239bf74bd4
, schedule : Text
, concurrencyPolicy : Optional Text
, failedJobsHistoryLimit : Optional Natural
, startingDeadlineSeconds : Optional Natural
, successfulJobsHistoryLimit : Optional Natural
, suspend : Optional Bool
}
