output "server_url" {
  value = var.server_url
}

output "registration" {
  value = {
    id               = acme_registration.registration.id
    registration_url = acme_registration.registration.registration_url
  }
}

output "certificates" {
  value = [for certificate in acme_certificate.certificates : {
    id                 = certificate.id
    certificate_url    = certificate.certificate_url
    certificate_domain = certificate.certificate_domain
    private_key_pem    = certificate.private_key_pem
    certificate_pem    = certificate.certificate_pem
    issuer_pem         = certificate.issuer_pem
    certificate_p12    = certificate.certificate_p12
  }]
}
