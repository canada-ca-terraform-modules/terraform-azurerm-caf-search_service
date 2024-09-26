locals {
  anti-pattern-regex = "/[//\"'\\[\\]:|<>+=;,?*@&]/"
  searchservice-name = lower(replace("${var.env}-${var.group}-${var.project}-${var.userDefinedString}-ss", local.anti-pattern-regex, ""))
}