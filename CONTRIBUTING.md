# Contributing Guidelines

This document contains information and guidelines about contributing to this project.
Please read it before you start participating.

# Introduction

Thanks for your interest in contributing! This repository is free open
source and as such dependent on your contributions. These guidelines should help
you get started more quickly and should ensure a smooth contribution process for
both those contributing and those reviewing contributions. Please read them
thoroughly before contributing with a Pull Request, and at least skim them before adding an issue.

We are open to all kinds of contributions as long as you follow our
[Code of Conduct](./CODE_OF_CONDUCT.md). For very specific use case it might make more sense
though to create your own repository instead of adding to this one.

**Topics**

* [How to Report a Bug](#how-to-report-a-bug)
* [Reporting Issues](#reporting-issues)
* [How to Request a Feature](#how-to-request-a-feature)
* [Submitting Pull Requests](#submitting-pull-requests)
* [Developers Certificate of Origin 1.1](#developers-certificate-of-origin-11)
* [Code of Conduct](#code-of-conduct)

# How to Report a Bug

**IMPORTANT!**

If you find a security vulnerability, do NOT open an issue. Email
[nv3212@gmail.com](mailto:nv3212@gmail.com&subject=Security%20vulnerability%20in%20repo)
instead. This reduces the risk of criminals getting aware and exploiting the
vulnerability before we got a chance to fix it.

In order to determine whether you are dealing with a security issue, ask yourself these two questions:
* Can I access something that's not mine, or something I shouldn't have access to?
* Can I disable something for other people?

If the answer to either of those two questions are "yes", then you're probably dealing with a security issue.
Note that even if you answer "no" to both questions, you may still be dealing with a security issue, so if you're
unsure, just email us at [nv3212@gmail.com](mailto:nv3212@gmail.com&subject=Security%20vulnerability%20in%20repo).

If the bug is not security related, please use the corresponding issue template
to submit it on GitHub.

# Reporting Issues

A great way to contribute to the project is to send a detailed issue when you encounter a problem. We always appreciate a well-written, thorough bug report.

Check that the project issues database doesn't already include that problem or suggestion before submitting an issue. If you find a match, feel free to vote for the issue by adding a reaction. Doing this helps prioritize the most common problems and requests.

When reporting issues, please fill out our issue template. The information the template asks for will help us review and fix your issue faster.

# How to Request a Feature

Please use the corresponding issue template to submit your idea on GitHub. Given
that this repo is a free open source project, chances of your idea
coming into fruition are much higher if you are also willing to contribute a PR.
Please first open the issue, though, so we can discuss the feature before you
have to spend time on it.

# Submitting Pull Requests

## License

Any contributions you make will be under the MIT Software License. In short,
when you submit code changes, your submissions are understood to be under the
same [MIT License](./LICENSE) that covers the project. Feel free to contact the maintainers
if that's a concern.

## Rules

We strongly recommend to first open an issue discussing the contribution before
creating a PR, unless you are really sure that the contribution does not need
discussion (e. g. fixing a typo in documentation).

We expect every contributor to adhere to our [Code of Conduct](./CODE_OF_CONDUCT.md). Additionally, please note that we can only merge a PR if:
* Commit messages follow [Conventional Commits guidelines](https://www.conventionalcommits.org/en/v1.0.0/)
  with scopes being limited to the names of the individual packages
  (e. g. `feat(compose): add typing for more than 6 parameters`)
* The code is following our linting guidelines as defined via SwiftLint rules in
  each project (run `swiftlint` to check)
* All tests pass.
* Bigger changes and new features are covered by an integration test.
* All relevant documentation is updated. Usually this means updating the Docc of the code you work on.
* Additional dependencies are only added with a good reason.

## Set up instructions

First please [fork this repository](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo)
to be able to contribute any changes.

After this, please run `make bootstrap` to install all dependencies. 

After all tools are installed, please open an Xcode and build the project to ensure that everything is set up correctly.

Now you can create a new branch describing the change you are about to make, e. g. `fix_typo_in_documentation`, and start coding.

## Your First Contribution

If you are interested in contributing, but don't have a specific issue at heart,
we would recommend looking through the issues labelled "help wanted".

If you are new to contributing to open source, we recommend to have a look at
a [free tutorial](http://makeapullrequest.com/) for this. Issues labelled "good first issue"
are meant specifically to get started in the repository.

If you are stuck at any point, feel free to comment in the issue you chose. We
try to be as helpful to newcomers as possible and you don't have to be afraid of
dumb questions.

# Developer's Certificate of Origin 1.1

By making a contribution to this project, I certify that:

- (a) The contribution was created in whole or in part by me and I
      have the right to submit it under the open source license
      indicated in the file; or

- (b) The contribution is based upon previous work that, to the best
      of my knowledge, is covered under an appropriate open source
      license and I have the right under that license to submit that
      work with modifications, whether created in whole or in part
      by me, under the same open source license (unless I am
      permitted to submit under a different license), as indicated
      in the file; or

- (c) The contribution was provided directly to me by some other
      person who certified (a), (b) or (c) and I have not modified
      it.

- (d) I understand and agree that this project and the contribution
      are public and that a record of the contribution (including all
      personal information I submit with it, including my sign-off) is
      maintained indefinitely and may be redistributed consistent with
      this project or the open source license(s) involved.

# Code of Conduct

The Code of Conduct governs how we behave in public or in private
whenever the project will be judged by our actions.
We expect it to be honored by everyone who contributes to this project.

See [CODE_OF_CONDUCT.md](https://github.com/space-code/flare/blob/master/CODE_OF_CONDUCT.md) for details.

---

*Some of the ideas and wording for the statements above were based on work by the [Docker](https://github.com/docker/docker/blob/master/CONTRIBUTING.md) and [Linux](https://elinux.org/Developer_Certificate_Of_Origin) communities.
