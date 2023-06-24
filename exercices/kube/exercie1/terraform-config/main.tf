provider "kubernetes" {
  config_path = "~/.kube/config"
}

// Création de ma ressource de déployement avec 5 réplicat
resource "kubernetes_deployment" "stevy-deployment" {
  metadata {
    namespace = "worketyamo"
    name      = "stevy-replicas"
    labels = {
      "owner" = "Stevy"
      "app"   = "StevyApp"
    }
  }

  spec {
    replicas = 5

    selector {
      match_labels = {
        app = "stevy-replicas"
      }
    }

    template {
      metadata {
        labels = {
          app = "stevy-replicas"
        }
      }

      spec {
        container {
          name  = "nginx-container"
          image = "smarlino/nginx-port-changed:latest"
        }

        container {
          name    = "httpd-container"
          image   = "smarlino/httpd-port-changed:latest"
          command = ["sleep"]
          args    = ["infinity"]
        }
      }
    }
  }
}

// Création du service NodePort pour exposé les ports de mes containers précédents
resource "kubernetes_service" "stevy-service-NodePort" {
  metadata {
    namespace = "worketyamo"
    name      = "stevy-service-node-port"
  }

  spec {
    selector = {
      app = "stevy-service-node-port"
    }

    port {
      name        = "nginx-port"
      port        = 5000
      target_port = 5000
    }

    port {
      name        = "httpd-port"
      port        = 8000
      target_port = 8000
    }

    type = "NodePort"
  }
}

