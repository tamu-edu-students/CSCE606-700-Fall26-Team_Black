_To access the project proposal, follow the [link](project_proposal.md)_

# README

R@1D is a bug-tracking application for development teams.

## Getting started

Install dependencies and prepare the database:

```sh
bin/setup
```

Run the development server with `bin/dev`. Devise's sign-up and sign-in pages are available at `/users/sign_up` and `/users/sign_in`.

## Authentication

Authentication uses Devise with email/password sign-in, self-service registration, password recovery, remember-me, and standard email/password validation. The generated views live in `app/views/devise` and can be customized by the team.

Users belong to projects through `Membership` records. Each membership stores a project-specific `developer`, `manager`, or `admin` role. Memberships require a user, project, and supported role, and a user can have only one membership per project. Authorization checks are not implemented here; a policy layer such as Pundit or CanCanCan can use the membership role to decide which actions are allowed.

Password recovery requires Action Mailer delivery to be configured for the target environment. Development and test URL hosts are configured; set a real sender and delivery settings before relying on email in production.

Run the specs with `bundle exec rspec` and the features with `bundle exec cucumber`.

See the [project proposal](project_proposal.md) for planned features and requirements.
