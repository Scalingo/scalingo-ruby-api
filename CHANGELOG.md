## Unreleased

* rename `BearerToken#expires_in` to `expires_at` (#16)
* rename argument `allow_guest:` for `API::Endpoint#connection` to `fallback_to_guest:` (#16)
* New API: billing api (#14)
  * New endpoint: `profile`. Methods: `show`, `create`, `update`

## 3.0.0.beta1 - 2020/06/12

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
