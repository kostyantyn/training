variable "dnsimple_token" {}

variable "dnsimple_account" {}

provider "dnsimple" {
  token   = "${var.dnsimple_token}"
  account = "${var.dnsimple_account}"
}

resource "dnsimple_record" "www" {
  domain = "www.site.com"
  type   = "A"
  name   = "site"
  value  = "${aws_instance.web.0.public_ip}"
}
