# Githubris

A GitHub API wrapper. Tries to have a strong DSL for performing complicated interactions.

## Authentication

### Basic Auth

Basic Auth is where you would supply your username and password. It is not as safe as other forms of authentication.

__Example:__
```ruby
Githubris.basic_auth('isaacsanders', 'REDACTED')
```
