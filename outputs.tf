output "server_url" {
  description = "The ACMEv2-compatible server URL used when issuing certificates."
  value       = var.server_url
}

output "registration" {
  description = "The ACMEv2 account registration details."
  value = {
    id               = acme_registration.registration.id
    registration_url = acme_registration.registration.registration_url
  }
}

output "certificates" {
  description = "The certificates and their contents."
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
