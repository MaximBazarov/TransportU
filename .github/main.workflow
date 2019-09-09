workflow "Check PR" {
  on = "pull_request"
  resolves = ["Checkout"]
}

action "Checkout" {
  uses = "Checkout"
  runs = "swift test"
}
