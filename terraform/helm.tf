resource "helm_release" "nginx" {
  name       = "nginx-ingress"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"

  create_namespace = true
  namespace        = "nginx-ingress"
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  create_namespace = true
  namespace        = "cert-manager"

  set = [
    {
      name  = "crds.enabled"
      value = true
    }
  ]

  values = [
    "${file("helm-values/cert-manager.yaml")}"
  ]
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"

  create_namespace = true
  namespace        = "external-dns"

  set = [{
    name : "wait-for"
    value = module.external_dns_irsa_role.iam_role_arn
  }]

  values = [
    "${file("helm-values/external-dns.yaml")}"
  ]
}

resource "helm_release" "argocd_deploy" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  timeout          = "600"
  namespace        = "argo-cd"
  create_namespace = true

  values = [
    "${file("helm-values/argocd.yaml")}"
  ]
}