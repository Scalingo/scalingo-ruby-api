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
