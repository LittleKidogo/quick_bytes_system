#!/bin/sh

release_ctl eval --mfa "QbBackend.ReleaseTasks.migrate/1" -- "$@"
