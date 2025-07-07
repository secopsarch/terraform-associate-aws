Absolutely! Here's a simple, real-world-style example for each **common Terraform variable type** — using a small `aws_instance` resource and showing how each type works with `for_each`, `count`, or meta-arguments.

---

## ✅ 1. `string` (Simple value)

```hcl
# variable
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# usage
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type

  tags = {
    Name = "StringExample"
  }
}
```

---

## ✅ 2. `list(string)` (Looping with `count`)

```hcl
# variable
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

# usage
resource "aws_subnet" "example" {
  count = length(var.availability_zones)

  vpc_id                  = "vpc-123456"
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "ListExample-${count.index}"
  }
}
```

---

## ✅ 3. `map(string)` (Using `for_each` with a map)

```hcl
# variable
variable "instance_names" {
  type = map(string)
  default = {
    web  = "t2.micro"
    db   = "t2.small"
    test = "t2.nano"
  }
}

# usage
resource "aws_instance" "example" {
  for_each      = var.instance_names
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = each.value

  tags = {
    Name = each.key
  }
}
```

---

## ✅ 4. `object` (A structured value)

```hcl
# variable
variable "server_config" {
  type = object({
    name         = string
    instance_type = string
    ami          = string
  })

  default = {
    name          = "my-app-server"
    instance_type = "t3.micro"
    ami           = "ami-0c55b159cbfafe1f0"
  }
}

# usage
resource "aws_instance" "example" {
  ami           = var.server_config.ami
  instance_type = var.server_config.instance_type

  tags = {
    Name = var.server_config.name
  }
}
```

---

## ✅ 5. `list(object)` (Multiple instances with custom config)

```hcl
# variable
variable "servers" {
  type = list(object({
    name          = string
    instance_type = string
  }))

  default = [
    { name = "web-1", instance_type = "t2.micro" },
    { name = "web-2", instance_type = "t2.small" }
  ]
}

# usage
resource "aws_instance" "example" {
  count         = length(var.servers)
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.servers[count.index].instance_type

  tags = {
    Name = var.servers[count.index].name
  }
}
```

---

## ✅ 6. `map(object)` (Named loop using `for_each`)

```hcl
# variable
variable "named_servers" {
  type = map(object({
    instance_type = string
    ami           = string
  }))

  default = {
    web  = { instance_type = "t2.micro", ami = "ami-0c55b159cbfafe1f0" }
    db   = { instance_type = "t2.small", ami = "ami-0c55b159cbfafe1f0" }
  }
}

# usage
resource "aws_instance" "example" {
  for_each = var.named_servers

  ami           = each.value.ami
  instance_type = each.value.instance_type

  tags = {
    Name = each.key
  }
}
```

---

## 🧠 Summary Table

| Variable Type  | Meta Argument Used | Use Case                                 |
| -------------- | ------------------ | ---------------------------------------- |
| `string`       | Direct assignment  | Single value input                       |
| `list(string)` | `count`            | Looping over availability zones, names   |
| `map(string)`  | `for_each`         | Looping by key-value pairs               |
| `object`       | Direct assignment  | Structured input for one item            |
| `list(object)` | `count`            | Create multiple resources with config    |
| `map(object)`  | `for_each`         | Named multiple resources with attributes |

---

Let me know if you want these wrapped into a reusable module or need examples for input via `terraform.tfvars`!
