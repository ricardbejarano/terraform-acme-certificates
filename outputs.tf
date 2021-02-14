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
  value       = acme_certificate.certificates
}
