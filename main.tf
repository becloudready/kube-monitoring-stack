provider "helm" {
  kubernetes {
    config_path = "/home/vagrant/.kube/helm-test"
  }
}

provider "kubernetes" {
  config_path = "/home/vagrant/.kube/helm-test"
}


resource "kubernetes_namespace" "test-namespace" {
  metadata {
        name = "test"
  }
}

resource "helm_release" "loki-grafana" {
  name       = "loki-grafana"
  namespace  = "test"
  
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  #repository = "https://charts.bitnami.com/bitnami"
  #chart      = "/home/vagrant/terraform-kube/loki-grafana/loki-stack"

  set {
    name  = "service.type"
    value = "NodePort"
  }
}

