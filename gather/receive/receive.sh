#!/bin/bash

gem install larch

larch --from imaps://imap.gmail.com --from-user [user]@gmail.com --from-pass [pass] --from-folder=Interesting --to imap://localhost --to-user [user]

