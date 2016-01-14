# Programs

There are 3 main programs in this system.  Also other front-end systems can consume the APIs

## Agent

 - self-contained static binary for easy of deployment and maximum portability.
 - connects to agent endpoint and authenticates self and server.
 - Can spawn TTY sessions with remote control.
 - Also exposes filesystem API (like sftp)
 - Can port forward (for remote debugging/testing of services)
 - Can run one-off shell commands
 - Can run one-off script functions
 - Can also schedule shell commands or script functions.
 - Script plugins are run by hash and downloaded/cached and synced on-demand.
    - agent downloads missing objects from repository through endpoint automatically.

## Script Repository

This is basically like an updated version of lit.luvit.io where we learned from
our mistakes and using Rackspace authentication.

 - Users can publish and browse scripts / libraries.
 - Uses git internally to revision scripts and to enable simple syncing using
   lit protocol.
 - Single namespace (but deep folders allowed) for scripts, first-come,
   first-serve.  Owner can add more owners to a script, stored in commit.
 - metadata for visibility, tags, etc.
 - Various levels of visibility depending on role (support racker, customer,
   agent team member, etc)
 - Exposes APIs through REST and websocket.

## Agent Endpoint

 - Public facing API with dual REST/websocket APIs
 - some APIs are websocket-only such as attaching to a TTY session stream.
 - Everything is audited/recorded.  Customers can see everything related to
   their servers, Rackers can see everything they've done, managers can see
   everything their employees have done.
 - proxies repository downloads for syncing script data.
 - one agent API will be the ability to send off metrics of other bulk data using
   the AEP as a proxy.
 - Maybe use repose as authentication layer.
 - APIs for managing/deploying agents.
 - Per agent chat rooms and maybe WebRTC signaling.  Also recorded and audited.

## Support Website

 - Customers deploy agents through web interface
 - Customers can request support through web interface
 - Support rackers can receive support requests
 - Support rackers can see machine/agent history as well as request special
   permissions like a TTY session.
 - Customers with paranoid settings can authorize security requests via web  
   interface.
 - Customers can watch actions live as well as review past items.
 - Support rackers can browse filesystem, change files, schedule or run commands
   or scripts, all through website.
 - Customers who want to can also access support tools for audited self-service.

# User Stories

The user stories will help guide implementation order and priority.  We can
implement the minimal functionality for each story, but see the future stories
to plan ahead when architecting code.

## Support TTY

This is a pretty big first step, but should make for a very impressive demo.

 - Customer logs into support site and requests support for a machine.
 - A support racker will take the case and see the question.
 - A text chat and optionally video chat will open.
 - Support racker clicks on `open TTY` button to request a terminal into the box.
 - Customer receives confirmation prompt which they accept.
 - Customer sees live tty session (read-only) while racker has interactive
   session.
 - Everything that anyone does through the agent is recorded and updated live on
   the screens of anyone looking at the agent's page.
 - Past actions are also listed and are viewable.

## Add in FileSystem Browsing / Editing

A second step would be adding in functionality for a racker to browse the files
on a box.  The audit system will record nearly everything including what folders
they open, what files they view, and any changes made.  This is also shown in
real-time on both sides and can be played back at a later date.

We can even go so far as to show the text editor as a racker edits a config file
complete with cursor.  The long-term record only needs remember the final state
of the file when saved.

## Automation - Shell Commands

In addition to giving more power to support rackers, we want to reduce the load on support rackers.  This step will add one-off commands that can be done purely through APIs. They will also be recorded and audited live of course.

## Automation - Scripts

Shell commands are limited to what's on the machine shell and form a more
automated version of the tty shell.  But scripts can run standalone logic within
the agent using the APIs provided in the sandbox.

## Scheduled Commands

In order to take over for the old monitoring system, we need the ability to run
commands or scripts on a schedule so that the agent can automatically do things
without first being told to do it every time by the AEP.
