# terraform-acme-certificates

A [Terraform](https://www.terraform.io/) module for the [ACMEv2](https://tools.ietf.org/html/rfc8555) protocol.


## Usage

The following example issues two [Let's Encrypt](https://letsencrypt.org/) [staging](https://letsencrypt.org/docs/staging-environment/) certificates: one for `example.com` and one for `example.org` and `www.example.org`, using the [DNS01](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge) challenge with [Cloudflare DNS](https://www.cloudflare.com/dns/). Then it outputs their contents.

```hcl
variable "cloudflare_token" {}

module "acme" {
  source = "ricardbejarano/certificates/acme"

  email_address = "you@example.com"

  certificates = [
    { common_name = "example.com" },
    { common_name = "example.org", subject_alternative_names = ["www.example.org"] },
  ]

  dns_challenges = [
    {
      provider = "cloudflare"
      config = {
        CLOUDFLARE_DNS_API_TOKEN = var.cloudflare_token
      }
    },
  ]
}

output "certificates" {
  value = module.acme.certificates
}
```

To switch to Let's Encrypt's production server, set the [`server_url`](variables.tf) variable. You may also switch to any [ACMEv2](https://tools.ietf.org/html/rfc8555)-compatible server.

You may find the full list of supported DNS providers [here](https://registry.terraform.io/providers/vancluever/acme/latest/docs).

You may find the full module reference within [`variables.tf`](variables.tf).


## License

MIT licensed, see [LICENSE](LICENSE) for more details.
