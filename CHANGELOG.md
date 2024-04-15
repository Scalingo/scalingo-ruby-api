## Unreleased

* Breaking change: rework DB api exposition
* Specs: rewrite all specs
* Breaking change: endpoint methods declaration is simplified:
    * based on URI templates
    * argument and method names are unified
    * one "main" internal method, `Endpoint#request`
* Breaking change: automatic digging of the value if the reponse body is an object with a single key
* Breaking change: remove `Scalingo::API::Reponse` in favor of `Faraday::Response`

## 3.5.0 - 2023-12-28

* Change: update Faraday to 2.x, released about two years ago. The public API of this gem doesn't change, therefore this is not a major release. However, if you manipulate directly faraday's objects, you may encounter breaking changes. Refer to [Faraday's website](https://lostisland.github.io/faraday/) for how to migrate.
* Compat: drop support for Ruby < 3. The lib is still expected to work for the time being.
* Compat: include Ruby 3.3 in the test matrix

## 3.4.0 - 2023-01-26

* New: Add `databases#upgrade` endpoint for database API ([#51](https://github.com/Scalingo/scalingo-ruby-api/pull/51))

## 3.3.0 - 2023-01-03

* Bugfix: response of Backups#create was not properly unpacked ([#44](https://github.com/Scalingo/scalingo-ruby-api/issues/44))
* New: Add default region for database API ([#45](https://github.com/Scalingo/scalingo-ruby-api/issues/44))

## 3.2.0 - 2022-12-23

* Removal: `Scalingo::Client#agora_fr1` had been removed since the region no longer exists.
* New: Add `addons#authenticate!` endpoint
* New API: database API
* New API: backup API

## 3.1.0

* Compat: support for ActiveSupport (and therefore Rails) 7, @Intrepidd

## 3.0.1

* Internals: allow `unpack` to dig into nested structures

## 3.0.0

* New: Regional API autoscalers endpoints
* New: User#stop_free_trial method

## 3.0.0.beta.3 - 2020/08/15

* Change: Requests have the header `Accept: application/json` by default
* Private API Change: `unpack` signature
* Change: allow api clients standalone use (without a main scalingo client)
* Change: remove regions-related configuration, except for the default region
* Bugfix: remove `https` configuration option (development artifact) (#20)
* Improv: configure the faraday adapter to use (#20)
* Improv: prettier `inspect` for common objects (#20)
* New: Add `addons#token` endpoint (#20)

## 3.0.0.beta.2 - 2020/06/18

* Bugfix: do not "dig" into the response body if it is not a 2XX (#18, #19)
* Rework configuration, add specs over it (#17)
* Rename `BearerToken#expires_in` to `expires_at` (#16)
* Rename argument `allow_guest:` for `API::Endpoint#connection` to `fallback_to_guest:` (#16)
* Response objects can access the operation directly using `.operation` (#15)
* New API: billing api (#14)
  * New endpoint: `profile`. Methods: `show`, `create`, `update`

## 3.0.0.beta.1 - 2020/06/12

* Full rewrite of the gem, **zero** backwards compatibility. Refer to the `README` for more information.

## 2.0.1 - 2019/12/11

* Bugfix: payload was not correctly serialized to JSON for POST/PUT/PATCH queries

## 2.0.0 - 2019/12/05

* Compatibility with new API tokens
* Compatibility with multi-region infrastructure
* Add missing resources: `regions`, `autoscalers`, `notifiers`, `alerts`

## 1.1.1 - 2019/01/08

* Update metadata on rubygems

## 1.1.0 - 2019/01/08

* Add /apps/:id/containers and /apps/:id/stats endpoints

## 1.0.0 - 2017/24/01

* First tag 1.0.0, API won't be broken

## 1.0.0.alpha1

* Initial alpha release
