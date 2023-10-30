resource "kubernetes_deployment" "hello_world_deployment" {
  metadata {
    name      = "kubernetes-example-deployment"
    namespace = "dev"
    labels = {
      app = "hello-world-example"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "hello-world-example"
      }
    }
    template {
      metadata {
        labels = {
          app = "hello-world-example"
        }
      }
      spec {
        container {
          image = "registry.gitlab.com/architect-io/artifacts/nodejs-hello-world:latest"
          name  = "hello-world"
        }
      }
    }
  }
}

resource "kubernetes_service" "hello_world_service" {
  depends_on = [kubernetes_deployment.hello_world_deployment]

  metadata {
    labels = {
      app = "hello-world-example"
    }
    name      = "hello-world-example"
    namespace = "dev"
  }

  spec {
    port {
      name        = "api"
      port        = 3000
      target_port = 3000
    }
    selector = {
      app = "hello-world-example"
    }
    type = "ClusterIP"
  }
}

resource "helm_release" "ingress_nginx" {
  depends_on = [kubernetes_service.hello_world_service]
  name       = "ingress-nginx"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
  namespace = "dev"
  timeout   = 300


}

resource "kubernetes_ingress_v1" "ingress" {
  depends_on = [helm_release.ingress_nginx]
  metadata {
    labels = {
      app = "ingress-nginx"
    }
    name      = "api-ingress"
    namespace = "dev"
    annotations = {
      "kubernetes.io/ingress.class" : "dev"
    }
  }

  spec {
    rule {
      http {
        path {
          path = "/"
          backend {
            service {
              name = "hello-world-example"
              port {
                number = 3000
              }
            }
          }
        }
      }
    }
  }
}

