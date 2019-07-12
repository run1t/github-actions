workflow "Build, Test, and Publish" {
    on       = "push"

    resolves = [
        "Master"
    ]
}

action "Build" {
    uses = "actions/npm@master"
    args = "--prefix ../.. install"
}

action "Test" {
    needs = "Build"
    uses  = "actions/npm@master"
    args  = "test"
}

# Filter for master branch
action "Master" {
    needs = "Test"
    uses  = "actions/bin/filter@master"
    args  = "branch master"
}
