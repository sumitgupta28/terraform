resource "github_repository" "terraform-repo-sumitgupta28" {
  name        = "terraform-repo-sumitgupta28"
  visibility  = "public"
  description = "created via terraform"
}

resource "github_repository" "terraform-repo-sumitgupta28-test" {
  name        = "terraform-repo-sumitgupta28-test"
  visibility  = "public"
  description = "created via terraform[terraform-repo-sumitgupta28-test]"
}



output "git_clone_url-1" {
  value = github_repository.terraform-repo-sumitgupta28.git_clone_url
}

output "full_name-1" {
  value = github_repository.terraform-repo-sumitgupta28.full_name
}

output "default_branch-1" {
  value = github_repository.terraform-repo-sumitgupta28.default_branch
}

output "description-1" {
  value = github_repository.terraform-repo-sumitgupta28.description
}

output "git_clone_url-2" {
  value = github_repository.terraform-repo-sumitgupta28-test.git_clone_url
}

output "full_name-2" {
  value = github_repository.terraform-repo-sumitgupta28-test.full_name
}

output "default_branch-2" {
  value = github_repository.terraform-repo-sumitgupta28-test.default_branch
}

output "description-2" {
  value = github_repository.terraform-repo-sumitgupta28-test.description
}
