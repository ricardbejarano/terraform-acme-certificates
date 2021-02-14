terraform {
  experiments = [module_variable_optional_attrs]

  required_providers {
    acme = {
      source = "vancluever/acme"
    }
  }
}

provider "acme" {
  server_url = var.server_url
}

provider "tls" {}

resource "tls_private_key" "registration" {
  algorithm = "RSA"
  rsa_bits  = var.account_private_key_rsa_bits
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.registration.private_key_pem
  email_address   = var.email_address

  dynamic "external_account_binding" {
    for_each = var.external_account_binding != null ? [null] : []
    content {
      key_id      = var.external_account_binding.key_id
      hmac_base64 = var.external_account_binding.hmac_base64
    }
  }
}

resource "acme_certificate" "certificates" {
  for_each = { for certificate in var.certificates : index(var.certificates, certificate) => certificate }

  common_name               = each.value.common_name
  subject_alternative_names = each.value.subject_alternative_names
  key_type                  = each.value.key_type
  must_staple               = each.value.must_staple
  min_days_remaining        = each.value.min_days_remaining
  certificate_p12_password  = each.value.certificate_p12_password

  account_key_pem              = acme_registration.registration.account_key_pem
  recursive_nameservers        = var.recursive_nameservers
  disable_complete_propagation = var.disable_complete_propagation
  pre_check_delay              = var.pre_check_delay

  dynamic "dns_challenge" {
    for_each = { for dns_challenge in var.dns_challenges : index(var.dns_challenges, dns_challenge) => dns_challenge }
    content {
      provider = dns_challenge.value.provider
      config   = dns_challenge.value.config
    }
  }
}
