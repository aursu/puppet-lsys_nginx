# Changelog

All notable changes to this project will be documented in this file.

## Release 0.49.0

**Features**

* **New class `lsys_nginx::njs`** and a `njs` parameter that installs the NGINX JavaScript dynamic module and loads it. Off by default: the package hard-depends on an exact nginx release - `nginx-module-njs 1.31.5+1.0.1` requires `nginx-r1.31.5` - so the two pins move together for the life of the host, and that should be a deliberate choice per node rather than something that arrives with the class. Note the version strings differ in shape, which is why `njs_package_ensure` exists rather than reusing `package_ensure`.
* **New `stream` parameter**, passed through to `nginx`, enabling the `stream` block and its `conf.stream.d` include directory. Needed for anything proxied at layer 4 rather than as HTTP.
* `njs_modules` selects which modules are loaded, defaulting to `ngx_stream_js_module` only.

**Notes**

* The ordering edge is load-bearing rather than tidiness: `Class['lsys_nginx::njs']` is placed before both `nginx::config` and `nginx::service`, because nginx refuses to start when a `load_module` directive names a file that is not on disk yet. On a host where nginx also fronts other services, getting that order wrong is an outage rather than a missing feature.

## Release 0.48.3

**Features**

* Test over nginx module v7.0.2

**Bugfixes**

**Known Issues**

## Release 0.46.0

**Features**

* Moved `lsys::nginx` into

**Bugfixes**

**Known Issues**

## Release 0.48.1

**Features**

* Changed operating systems supported
* Dependencies update
* Default nginx version for Ubuntu updated to 1.27.3

**Bugfixes**

**Known Issues**

## Release 0.48.2

**Features**

* Default nginx version for Ubuntu updated to 1.27.4

**Bugfixes**

**Known Issues**
