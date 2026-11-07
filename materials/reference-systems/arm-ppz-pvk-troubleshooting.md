# ARM PPZ/PVK — ViPNet Coordinator and browser troubleshooting

## Scope and provenance

This page records the supplied user-guide fragment for an ARM PPZ/PVK environment. It is not part of the ARM Descriptor architecture unless an independent primary source establishes that relationship.

The guide refers to a ViPNet Monitor coordinator, a portal, browser behavior, printer/card-reader/web-camera drivers and browser plugins.

## Coordinator available, portal unavailable

The historical troubleshooting instruction says to:

1. Open ViPNet Monitor.
2. Open the properties of Coordinator #3.
3. Inspect the **Tunnel** tab.
4. Check that both portal addresses are configured: `172.111.222.8` and `172.25.254.6`.
5. If one or both are missing, add the addresses according to the approved local configuration and save.
6. Verify the portal address entered in the browser. The guide specifies `http://172.111.222.8`, not HTTPS and not the alternative hostname mentioned in the source.
7. Check whether an unrelated public website opens. If it does not, the guide suggests a browser problem and recommends another or updated browser.
8. If the portal still does not open, escalate to the network administrator.

**Important:** These are historical instructions copied from the supplied guide. They must not be applied blindly to a live environment. The addresses, coordinator number, tunnel policy, URL scheme and security requirements must be confirmed by the responsible network administrator. Do not disable TLS validation, bypass security controls or change a production tunnel without authorization.

## Portal opens, but preview/photo/print windows are blank

The guide attributes blank preview, photo-capture or print windows to browser compatibility or missing plugins. It mentions Adobe Flash Player and similar plugins.

Adobe Flash Player is end-of-life and must not be installed or re-enabled as a modern workaround. Any legacy browser/plugin dependency requires an isolated, approved environment and a security review. Prefer a vendor-supported replacement or migration path.

## Historical workstation prerequisites

The source lists:
- card-reader, printer and (where needed) web-camera drivers;
- Adobe Reader with browser integration enabled;
- Adobe Flash Player browser plugin;
- browser permission for pop-up windows;
- JavaScript execution enabled;
- cookies enabled;
- explicit permission for the Flash plugin to access the webcam on first use, followed by saving the setting.

These are historical prerequisites, not current browser hardening recommendations. Modern browser versions generally do not support Flash.

## Diagnostic checklist for an authorized administrator

- Confirm that the correct coordinator and tunnel profile are selected.
- Compare configured tunnel addresses with the current approved network configuration.
- Confirm DNS/routing/firewall policy and portal service health using approved administrative tools.
- Confirm the correct URL and supported protocol from the current service owner.
- Check browser compatibility and required device drivers.
- Review browser console and application logs without exposing personal data or credentials.
- Escalate persistent connectivity or service failures to the network administrator/service owner.

## Unknowns

- Current ownership and status of the portal.
- Whether the addresses remain valid.
- Whether Coordinator #3 is still the correct coordinator identifier.
- Supported browser and plugin versions.
- Current authentication and transport-security requirements.
- Whether the guide belongs to a specific PPZ/PVK release or deployment.
