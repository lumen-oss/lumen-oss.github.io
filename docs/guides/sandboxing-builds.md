---
slug: /guides/sandboxing-builds
id: sandboxing-builds
title: How to sandbox package builds
sidebar_label: Sandboxing builds
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

1. Add the `[build] runner` config to your config file (`lx config edit`).
2. The runner must cover the directories Lux writes to during a build: the
   temporary build directory (usually under `/tmp`), the install tree (under the
   data directory or your project's `.lux` directory),
   and cache directories for the various build backends
   (e.g. Cargo for `rust-mlua` projects).
3. Verify with a package that writes outside those directories: it should fail.
4. Permission errors during a build mean a missing readable or writable directory.

<Tabs>
<TabItem value="linux" label="Linux">

Install [bubblewrap](https://github.com/containers/bubblewrap), then use:

```toml
[build]
runner = [
    "bwrap",
    "--ro-bind", "/", "/",
    "--dev-bind", "/dev", "/dev",
    "--proc", "/proc",
    "--bind", "/tmp", "/tmp",
    "--bind", "<cache-dir>", "<cache-dir>",
    "--bind", "<data-dir>", "<data-dir>",
    "--unshare-net",
    "--new-session",
]
```

</TabItem>
<TabItem value="macos" label="macOS">

Write a seatbelt profile, e.g. `~/sandbox.sb`:

```
(version 1)
(deny default)
(allow file-read*)
(allow process*)
(allow sysctl-read)
(allow file-write* (subpath "/tmp") (subpath "<cache-dir>") (subpath "<data-dir>"))
```

Then use:

```toml
[build]
runner = ["sandbox-exec", "-f", "/Users/alice/sandbox.sb"]
```

</TabItem>
</Tabs>
