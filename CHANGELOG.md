# CHANGELOG

## 0.9.1

- add default "backupper" user password

  This password is not really used (ssh connection is key- based), but without
  a password, and sshd's `UsePAM` set to `no`, the connection cannot be
  established due to the fact that the password field in the shadow file
  contains "!", which sshd then intrepids as a "locked account":

      User backupper not allowed because account is locked

  If you have a need to know this password, you should override it with your
  own.

## 0.9.0

- initial commit of `backuppc-client`
