# Changelog

All notable changes to this project will be documented in this file.

## Release 0.50.0

**Features**

* **Default nginx version now tracks current mainline**: `1.31.6` on Debian/Ubuntu and EL8+, replacing `1.27.4`, which had been the default since 2025-03-18. Verified against nginx.org on 2026-09-22.
* The Debian default became a selector on the codename. focal is capped at `1.27.5-1~focal` because nginx.org stopped building mainline for it there; jammy and noble both reach `1.31.6`. A flat default would have pinned focal to a version that does not exist in its suite.

**Notes**

* This is a security fix, not housekeeping. `1.27.4` is below the CVE-2026-42945 fix line (>= 1.30.1), so every host that included this class without pinning `package_ensure` was being *held* on a vulnerable nginx - and any host that had been upgraded out of band was actively downgraded back onto it. That is not hypothetical: on 2026-09-22 `dev-web-013`, the Frankfurt Puppet master, reported `Package[nginx]/ensure: ensure changed '1.31.6-1~noble' to '1.27.4-1~noble' (corrective)` on its Puppet Server reverse proxy. It was the only nginx host in the estate without a pin, which is why it was the only one affected.
* Hosts that pin `package_ensure` are unaffected by this change; the pin still wins. The default matters for a host that includes the class and says nothing, which is exactly the case that was silently wrong.
* `nginx-module-njs` hard-depends on an exact nginx release, so a host with `njs => true` must move `njs_package_ensure` in step. A matching `1.31.6+1.0.1` build exists for noble. No host in this estate currently enables njs.

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
