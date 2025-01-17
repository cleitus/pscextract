project = "prosanteconnect/pscextract"

# Labels can be specified for organizational purposes.
labels = { "domaine" = "psc" }

runner {
    enabled = true
    data_source "git" {
        url = "https://github.com/prosanteconnect/pscextract.git"
    }
}

# An application to deploy.
app "prosanteconnect/pscextract" {
  # the Build step is required and specifies how an application image should be built and published. In this case,
  # we use docker-pull, we simply pull an image as is.
  build {
    use "docker-pull" {
      image = var.image
      tag   = var.tag
    }
  }

  # Deploy to Nomad
  deploy {
    use "nomad-jobspec" {
      jobspec = templatefile("${path.app}/pscextract.nomad.tpl", {
        public_hostname = var.public_hostname
        image = var.image
        tag = var.tag
      })
    }
  }
}

variable "public_hostname" {
  type    = string
  default = "pscextract.psc.api.esante.gouv.fr"
}

variable "image" {
  type    = string
  default = "prosanteconnect/pscextract"
}

variable "tag" {
  type    = string
  default = "latest"
}
